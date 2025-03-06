# E-Port Farmly  

## Overview  
E-Port Farmly is a mobile and backend solution designed for offline data collection in the agricultural sector. The system allows clerks to collect farmer data and administrators to configure form options. It supports offline functionality and syncs data with a FastAPI backend when online.  

## Features  
### **Mobile App (Flutter)**
- **User Roles:**  
  - **Clerk:** Collects farmer data, including Name, National ID, Farm Type, Crop, and Location.  
  - **Admin:** Configures available options for crop types, farm types, etc.  
- **Offline Mode:** Allows data collection without an internet connection.  
- **Synchronization:** Automatically syncs data when the app is back online.  
- **Authentication:** Secure login system for users.  

### **Backend (FastAPI)**  
- **User Management:**  
  - `POST /users/login/access-token` → Login and obtain an access token.  
  - `POST /users` → Create a new user.  

- **Farm Data Management:**  
  - **Crops:**  
    - `POST /farms/crops` → Add a crop.  
    - `GET /farms/crops/sync` → Fetch crops from the backend.  
    - `POST /farms/crops/sync` → Sync crops.  
  - **Farm Types:**  
    - `POST /farms/farm_types` → Add a farm type.  
    - `GET /farms/farm-types/sync` → Fetch farm types.  
    - `POST /farms/farm-types/sync` → Sync farm types.  
  - **Farmer Data:**  
    - `POST /farms/farmer-data` → Submit collected farmer data.  
    - `GET /farms/farmer-data/sync` → Fetch farmer data.  
    - `POST /farms/farmer-data/sync` → Sync farmer data.  

- **Health Check:**  
  - `GET /health` → Check API health status.  

## API Documentation  
- OpenAPI Specification (OAS 3.1) available at:  
  - `/api/v1/openapi.json`  

## Installation & Setup  
### **Backend (FastAPI)**
1. Clone the repository:  
   ```bash
   git clone https://github.com/aurthurm/farmly.git
   cd farmly/farmly-backend
   ```
2. Install dependencies:  
   ```bash
   pip install -r requirements.txt
   ```
3. Run the FastAPI server:  
   ```bash
   cd src
   fastapi dev main.py --host 0.0.0.0
   ```
4. Access API documentation:  
   - Swagger UI: `http://localhost:8000/docs`  
   - Redoc: `http://localhost:8000/redoc`  

### **Mobile App (Flutter)**
1. Navigate to the mobile app directory:  
   ```bash
   cd farmly/farmly_mobile
   ```
2. Install dependencies:  
   ```bash
   flutter pub get
   ```
3. Run the application:  
   ```bash
   flutter run
   ```
