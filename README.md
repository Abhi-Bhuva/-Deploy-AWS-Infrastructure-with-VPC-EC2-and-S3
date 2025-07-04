# 🚀 AWS Infrastructure Deployment with Terraform

This project demonstrates how to use **Terraform** to deploy a basic AWS infrastructure that includes:

* A **Virtual Private Cloud (VPC)**
* A **Public Subnet** with **Internet Gateway**
* An **EC2 Instance**
* An **S3 Bucket**

---

## 📁 Project Structure

```bash
aws-infra/
├── main.tf           # Main Terraform configuration
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── README.md         # Project documentation
```

---

## 📸 Architecture Diagram

---

## 🔧 Prerequisites

* AWS Account with configured credentials (`aws configure`)
* Terraform installed on your system
* A pre-created AWS EC2 Key Pair (used for SSH access)

---

## 📦 Resources Created

1. **VPC**: A custom VPC with CIDR `10.0.0.0/16`
2. **Subnet**: Public subnet in `ap-south-1a`
3. **Internet Gateway**: Attached to the VPC
4. **Route Table**: Routes internet traffic from the subnet
5. **Security Group**: Allows inbound SSH (port 22)
6. **EC2 Instance**: Amazon Linux 2, t2.micro
7. **S3 Bucket**: Unique globally-named bucket

---

## ⚙️ How to Deploy

### 1. Clone the Repo

```bash
git clone https://github.com/your-repo/aws-infra.git
cd aws-infra
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Apply Configuration

```bash
terraform apply -var="key_name=your-key" -var="bucket_name=your-unique-bucket-name"
```

Confirm with `yes` when prompted.

### 4. Output

* Public IP of the EC2 instance
* S3 bucket name

---

## 📤 To Destroy the Infrastructure

```bash
terraform destroy -var="key_name=your-key" -var="bucket_name=your-unique-bucket-name"
```

---

## 📚 Notes

* Make sure the S3 bucket name is **globally unique**.
* Replace `your-key` with your **actual EC2 Key Pair** name.
* This project uses **Mumbai region (ap-south-1)** by default. You can change it in `main.tf`.

---

## 📸 Screenshots

### Terraform Apply Example
images/terraform apply-1.png,images/terraform apply-2.png 
### AWS Console Verification
images/aws console-ec2.png, images/vpc-console.png
---

## 🧠 Author

**Abhi Bhuva**
DevOps Engineer

---

Feel free to customize this setup to fit more complex architectures (e.g., private subnets, RDS, ALB, auto scaling, etc.).
