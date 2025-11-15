# 🏥 Hospital App – COVID-19 Patient Management System  
*A Cloud Computing SaaS Project – Ruby on Rails*

## 📌 Overview  
The **Hospital App** is a cloud-hosted **Software-as-a-Service (SaaS)** application designed to manage COVID-19 patient records. It is built using **Ruby on Rails** and demonstrates full CRUD functionality, authentication, cloud deployment, API integration, and a responsive frontend.

This project was developed as part of the **Cloud Computing module** for the BSc (Hons) in Computing at the National College of Ireland.

---

## 🚀 Live Demo  
- **🌐 Deployment (Render):** https://hospital-app-1-ahlp.onrender.com  
- **📁 GitHub Repository:** https://github.com/AlexMGarbalyauskas/Hospital_App  
- **🎬 Project Demo Video:** *(Insert YouTube Link)*  

---

## 🛠️ Technologies Used  

### **Frontend**
- HTML / ERB  
- CSS, Bootstrap  
- JavaScript (Plotly.js, custom logic)  
- Rails Partials and Layouts  

### **Backend**
- Ruby on Rails (MVC)  
- ActiveRecord  
- ActiveStorage (Local + AWS S3)  
- Pundit (Authorization)  
- Turbo-Rails  
- RSpec  

### **Database**
- PostgreSQL  

### **Cloud & DevOps**
- GitHub (CI)  
- Render.com (Cloud Deployment)  

### **External APIs**
- `disease.sh` COVID-19 API  
- Google Maps API  
- Country vaccine data  

---

## ✨ Features  

### 🧑‍⚕️ Patient Management (CRUD)
- Create, Edit, View, and Delete patient records  
- Fields include: name, age, gender, diagnosis, vaccinated, critical status, date of cure/death, reasons, etc.  
- Upload and store profile pictures (ActiveStorage)  

### 🔍 Search & Filter
- Search patients by name, age, gender, diagnosis and more  
- Filter reset with a single click  

### 🗑️ Mass Deletion  
- Delete multiple patient records at once  

### 🔐 Authentication  
- User sign-up and login via ActionView  
- Secure session cookies  
- Navbar shows logged in email  

### 🛡️ Authorization  
- Implemented using **Pundit**  
- Restricts actions based on user permissions  
- Necessary for Render deployment security  

### 🌍 API Dashboards  
- Global COVID-19 data  
- Vaccination statistics  
- Interactive maps  
- Timeline charts (Plotly.js)  
- Rendered using iframe-linked minimal layouts  

### 🎨 UI Enhancements  
- Responsive Bootstrap UI  
- Dynamic flash messages  
- Image carousel  
- Patient cards change color based on treatment status  

---

## 📂 Project Structure  

