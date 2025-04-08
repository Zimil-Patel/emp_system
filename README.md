# 🧑‍💼 Employee Management System (Flutter + Firebase)

A smart, real-time employee management system built with **Flutter**, integrated with **Firebase** for authentication, attendance tracking, leave management, and report handling. It supports both employee and supervisor roles with role-based access.

---

## 📲 Features

### 🔐 Authentication
- Email & Password login
- Role-based login (Employee / Supervisor)
- Lottie animation buttons during auth
- Update profile (name & photo)

### 📆 Attendance Management
- Daily Check-In / Check-Out
- Late/Early Leave detection
- Location verification (via Google Maps)
- Absent/Checkout-Missing detection
- Reason prompt for late check-in or early leave

### 📅 Calendar View
- Interactive calendar for attendance
- attendance color-coded on calendar

### 📊 Statistics & Insights
- Employee dashboard showing:
    - Total Presents
    - Absents
    - Late Comers
    - Early Leavers
- Filtered views for each

### 📋 Reports Module (Unified Incident & Issue)
- Create report via dialog (not page)
- Fields: type, title, description, reportedBy, reportedDate, status, resolution
- Supervisors can mark reports as resolved

### 🌴 Leave Management
- Apply leave with reason, date range
- View past leaves with status
- Supervisor approval mechanism

---

## 🛠️ Tech Stack

| Layer           | Technology           |
|----------------|----------------------|
| **Frontend**    | Flutter              |
| **Backend**     | Firebase Firestore   |
| **Auth**        | Firebase Auth        |
| **Storage**     | Firebase Storage (for profile & image reports) |
| **State Mgmt**  | GetX                 |
| **Local DB**    | SQLite (for offline backup) |
| **Maps**        | Google Maps          |

---

## 🧪 Testing Features

- Internet handling (offline fallback using SQLite)
- Conflict-free Firebase <=> SQLite sync
- Mock employees and attendance data preloaded
- Randomized check-in/out times (for real-world behavior)

---

## 🧑‍💼 User Roles

### 👨‍💼 Employees:
- Mark attendance
- View their calendar stats
- Apply leave
- Raise issues/reports

### 👩‍💼 Supervisors:
- View all employee stats
- Approve leaves
- Resolve reports
- View any attendance data

---