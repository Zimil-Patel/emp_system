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

## Screenshots

<div align="left">
   
<!-- GitHub-hosted images from Mockups folder -->
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/attendance_filter-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/attendance_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/csv_share-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/early_leave_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/edit_profile-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_add_report_dialog-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_cal_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_change_pass-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_drawer-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_home-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<!-- GitHub-hosted images from Mockups folder -->
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/attendance_filter-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/attendance_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/csv_share-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/early_leave_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/edit_profile-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_add_report_dialog-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_cal_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_change_pass-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_drawer-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_home-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_home_2-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_home_3-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_leave_add_dialog-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_leave_date_picker-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_leave_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_list_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_logout_dialog-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_report_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/emp_stat_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/forgot_pass_dialog-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/late_comer_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/mail_alert-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/map_early_leave-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/map_failed-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/map_late_come-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/map_success_2-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/map_sucess-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/pass_reset_alert-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/pdf_share-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/role_option-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/sign_in-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/sign_in_sign_up-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/sign_up-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/splash-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/super_cal_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/super_drawer-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/super_home_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/super_leave_dialog-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/super_leave_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/super_report_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/super_report_resolve_dialog-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/super_sign_in-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Zimil-Patel/emp_system/blob/master/Mockups/super_stats_page-portrait.png?raw=true" height="590" width="300">&nbsp;&nbsp;&nbsp;&nbsp;

<!-- Continue same format for remaining files... -->

</div>
