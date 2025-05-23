# Terraform AWS S3 Static Website Hosting

This project sets up a **static website** hosted on **Amazon S3** using **Terraform**. It automates the creation and configuration of the S3 bucket, uploads static files, and optionally configures the bucket for website hosting with public access.

## 🌐 Features

- Creates an S3 bucket for static website hosting
- Enables static website hosting configuration (index.html, error.html)
- Sets public access permissions to allow internet access to the site
- Uploads static files to the bucket (if configured)
- Outputs the website endpoint URL

## 🛠️ Technologies Used

- [Terraform](https://www.terraform.io/) - Infrastructure as Code tool
- [AWS S3](https://aws.amazon.com/s3/) - Cloud object storage service

## 📁 Project Structure

```bash
.
├── main.tf              # Main Terraform configuration
├── variables.tf         # Input variables
├── outputs.tf           # Outputs like S3 URL
├── index.html           # Your website’s main page
├── error.html           # Error page (optional)
└── README.md            # Project documentation
