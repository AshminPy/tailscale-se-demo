# Tailscale Subnet Router Demo on AWS (Terraform + GitOps)

This repository demonstrates how to deploy a **Tailscale Subnet Router** on **AWS using Terraform**, following **production-ready patterns**.

You can run the demo in two ways:

1. Local Terraform (simple)
2. GitHub Actions + AWS OIDC (no AWS keys, full CI)

## 1. Business Value (Why This Matters)

**Tailscale Subnet Router** lets you reach private AWS resources **without**:

- VPN appliances
- Bastion hosts
- Public IPs
- Opening many ports
- Managing SSH keys manually

## Benefits

- **Zero-trust access** (identity-based)
- **Encrypted point-to-point traffic** (WireGuard)
- **No public exposure**
- **Simple routing** (advertise one subnet)
- **Cross-cloud friendly** (AWS, GCP, home lab, laptop)

This demo replaces slow, complex VPN designs with a clean modern approach.

---

## Deployment resources

| Component              | Purpose                              |
| ---------------------- | ------------------------------------ |
| Public EC2             | Acts as **Tailscale Subnet Router**  |
| Private EC2            | Reachable only via Tailscale         |
| VPC + Subnets          | Network infrastructure               |
| SGs                    | Security groups (ICMP/TCP allowed)   |
| IAM Roles              | Least-privilege Terraform + EC2      |
| AWS Secrets Manager    | Stores Tailscale auth key            |
| S3 + DynamoDB          | Terraform remote backend             |
| GitHub OIDC (optional) | CI/CD without static AWS credentials |

After deploy, you can:

- `tailscale ping` and `ssh` into **private EC2 (no public IP)**
- Validate **advertise-routes functionality**
- Prove **zero-trust connectivity**

---

## How It Works (High-Level)

1. Public EC2 joins your Tailnet.
2. It advertises AWS subnet (example: `10.10.2.0/24`) to Tailscale.
3. Tailscale distributes this route.
4. All Tailnet devices can access the private EC2 securely.

Use cases: replace VPNs, cross-cloud access, secure internal connectivity.

---

## AWS Tailscale Subnet Router Architecture

![AWS Tailscale Subnet Router Architecture](docs/tailscale-aws-subnet-router.png)

---

## Prerequisites

### AWS

- AWS Account
- IAM permissions: EC2 / VPC / IAM / SecretsManager / S3 / DynamoDB
- AWS CLI configured (`aws configure`)

### Local

- Terraform `>=1.5`
- Git
- Tailscale account (Admin)
- pre-commit
- tflint
- tfsec
- terraform-docs
- tailscale

### Tailscale Auth Key

Create at: **Admin → Settings → Keys**

| Setting   | Value             |
| --------- | ----------------- |
| Reusable  | ON                |
| Ephemeral | OFF (recommended) |

---

## Pre-Terraform AWS Setup

```bash
# S3 backend
aws s3api create-bucket \
  --bucket ts-demo-backend-bucket \
  --region ca-central-1 \
  --create-bucket-configuration LocationConstraint=ca-central-1

# DynamoDB state locking
aws dynamodb create-table \
  --table-name ts-demo-tf-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

# Store Tailscale auth key to secret
aws secretsmanager update-secret \
  --secret-id ts-aws-demo-tailscale-auth \
  --secret-string "tskey-auth-xxxx" \
  --region ca-central-1
```

## Deployment Steps

### Method A - Run Locally

#### Step 1: Clone repo

```
git clone https://github.com/AshminPy/tailscale-se-demo.git
cd tailscale-se-demo
```

#### Step 2: Install & Run pre-commit

```
pre-commit install
pre-commit run --all-files
```

#### Step 2: Go to AWS environment

```
cd envs/aws
```

#### Step 3: Initialize Terraform (uses S3/DynamoDB backend)

```
terraform init
```

#### Step 4: Review plan

```
terraform plan
```

### Step 5: Apply

```
terraform apply -auto-approve
```

## Verification

### 1. Confirm subnet router is visible

```
tailscale status
```

### 2. Ping private EC2

```
tailscale ping 10.10.2.10
```

### 3. SSH via Tailscale

```
ssh ubuntu@10.10.2.10
```

Success = routing active, advertise-routes working, private EC2 accessible.

### Method B — GitHub Actions (OIDC + CI/CD)

You can run Terraform plan and apply through GitHub Actions without storing AWS credentials.

## Create GitHub OIDC IAM Role

reference: https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-aws

sample : using cloudformation

```
AWSTemplateFormatVersion: "2010-09-09"
Description: GitHub OIDC + IAM Role for Terraform CI

Resources:
  GitHubOIDCProvider:
    Type: AWS::IAM::OIDCProvider
    Properties:
      Url: https://token.actions.githubusercontent.com
      ClientIdList:
        - sts.amazonaws.com
      ThumbprintList:
        - 2b18947a6a9fc7764sdd8b5fb18a863b0c6dac24f

  GitHubTerraformRole:
    Type: AWS::IAM::Role
    Properties:
      RoleName: terraform-git-ci-role
      AssumeRolePolicyDocument:
        Version: "2012-10-17"
        Statement:
          - Effect: Allow
            Principal:
              Federated: !Ref GitHubOIDCProvider
            Action: sts:AssumeRoleWithWebIdentity
            Condition:
              StringEquals:
                token.actions.githubusercontent.com:sub: "repo:<GITHUB_USER>/<REPO>:ref:refs/heads/main"

      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/AmazonS3FullAccess
        - arn:aws:iam::aws:policy/AmazonEC2FullAccess
        - arn:aws:iam::aws:policy/AmazonVPCFullAccess
        - arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess
        - arn:aws:iam::aws:policy/IAMReadOnlyAccess

      Policies:
        - PolicyName: RWSecrets
          PolicyDocument:
            Version: "2012-10-17"
            Statement:
              - Effect: Allow
                Action:
                  - secretsmanager:GetSecretValue
                  - secretsmanager:PutSecretValue
                  - secretsmanager:GetResourcePolicy
                  - secretsmanager:CreateSecret
                Resource: "*"
```

Note you can also use git secrets for storing secrets example:

```
AWS_ROLE_ARN      arn:aws:iam::123456789012:role/github-oidc-role
AWS_REGION        ca-central-1
TS_SECRET_NAME    ts-aws-demo-tailscale-auth
EC2_KEY_SECRET    ts-aws-demo-ec2-key

```

#### Run CI Workflow

```
git add .
git commit -m "trigger ci"
git push

```

Current workflow shows The workflow does:

terraform init
terraform plan
(as its a test demo - I am running tf apply locally , but you can add tf apply to the actions flow and enable on PR merge )

## Cleanup

```
cd envs/aws
terraform destroy -auto-approve
```

### (Optional) delete secret

```
aws secretsmanager delete-secret --secret-id ts-aws-demo-tailscale-auth
```

## Reference

https://tailscale.com/kb/1019/subnets
