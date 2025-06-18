# 🏋️‍♂️ KODE Sports Club Membership - Odoo Module

This Odoo module provides a comprehensive membership management system for **KODE Sports Club**, handling member registration, branch assignments, blacklist workflows, revision requests, and detailed reporting.

---

## 🛠️ Prerequisites

Before installing the module, ensure the following requirements are met:

- **Odoo**: Version 16 or later
- **Docker**: Latest version installed
- **Python**: 3.8+ (for Odoo compatibility)
- **Dependencies**: Odoo modules `base`, `mail`, and `sale`

---

## 🚀 Installation (Docker)

Follow these steps to set up the module using Docker:

1. **Clone the Repository**:

   ```bash
   git clone <your-repo-url>
   cd KODE-Sports-Club-Membership
   ```

2. **Ensure Module Placement**:

   - Place the `kode_membership` module in the `custom_addons/` directory.

3. **Build and Run Containers**:

   ```bash
   docker compose up -d --build
   ```

4. **Access Odoo**:

   - Open your browser and navigate to: `http://localhost:8069`
   - Log in with:
     - **Username**: `admin`
     - **Password**: `admin` (default, as per `odoo.conf`)

5. **Install the Module**:
   - In Odoo, go to **Apps** → **Update Apps List** → Search for `kode_membership` → **Install**.

> **Note**: Ensure the `custom_addons/` path is correctly mapped in your `docker-compose.yml` file.

---

## 🌟 Module Features

### ✅ Member Management

- Create and manage member profiles with bilingual (English/Arabic) names, images, and branch assignments.
- Track membership statuses: `Draft`, `Approved`, or `Black List`.
- Integrate with `res.partner` for seamless CRM compatibility.
- Automatically compute renewal details, including last order, date, and total amount.

### 🏢 Branch Management

- Define and manage club branches with unique names and locations.
- Assign members to multiple branches (many-to-many relationship).
- Monitor member counts per branch for operational insights.

### ⛔ Blacklist Workflow

- Blacklist members with detailed reasons using a dedicated wizard.
- Maintain a comprehensive blacklist history in `kode.blacklist.history`.

### ♻️ Revision Request Workflow

- Submit revision requests for blacklist status changes via a wizard.
- Prevent duplicate pending requests for the same blacklist entry.
- Managers can `Accept` or `Deny` requests, with `Accepted` requests resetting member status to `Draft`.

### 🛡️ Access Control

- **Manager Group**: Full access to all members, blacklist, and revision workflows.
- **User Group**: Restricted to viewing `Approved` or `Black List` members only.
- Managers exclusively control revision status updates.

### 📊 Reporting

- **Excel Report**: Export member details (names, status, renewal data, and total last order price) in a formatted Excel file.
- **QWeb Report**: Generate printable HTML/PDF reports with member details and assigned branches, styled with Bootstrap.

---

## 📂 Module Structure

```plaintext
kode_membership/
├── __init__.py          # Module initialization
├── __manifest__.py        # Module metadata
├── models/              # Business logic and data models
│   ├── __init__.py
│   ├── kode_member.py
│   ├── kode_branch.py
│   ├── blacklist_history.py
│   ├── blacklist_revision_request.py
│   ├── blacklist_wizard.py
│   ├── revision_request_wizard.py
├── wizards/               # Wizard views
│   ├── blacklist_wizard_view.xml
│   ├── revision_request_wizard_view.xml
├── reports/               # Reporting logic
│   ├── xlsx_member_report.py # Excel report
│   ├── member_report.xml  # PDF report
├── security/              # Access control
│   ├── groups.xml
│   ├── rules.xml
│   ├── ir.model.access.csv
├── data/                  # Configuration data
│   ├── ir_sequence_data.xml
├── views/                 # User interface
│   ├── menus.xml
│   ├── kode_member_views.xml
│   ├── kode_branch_views.xml
│   ├── res_partner_view.xml
│   ├── blacklist_history_view.xml
│   ├── blacklist_revision_request_view.xml
└── README.md              # You are here!
```

---

## 🔐 Security & Permissions

### Groups (`groups.xml`)

- **Manager**: `group_membership_manager` (full access)
- **User**: `group_membership_user` (limited access)

### Record Rules (`rules.xml`)

- **Users**: Can only view `Approved` or `Black List` members.
- **Managers**: Have unrestricted access to all members and workflows.

### Access Rights (`ir.model.access.csv`)

| Model                             | Manager | User    |
| --------------------------------- | ------- | ------- |
| `kode.member`                     | ✅ Full | ✅ R/W  |
| `kode.branch`                     | ✅ Full | ✅ Full |
| `res.partner`                     | ✅ Full | ✅ Full |
| `kode.blacklist.history`          | ✅ Full | ⛔ None |
| `kode.blacklist.revision.request` | ✅ Full | ⛔ None |
| `kode.blacklist.wizard`           | ✅ Full | ✅ Full |
| `kode.revision.request.wizard`    | ✅ Full | ✅ Full |

---

## 🧠 Business Logic Highlights

- **Unique Identifiers**: Auto-generated codes for members, branches, blacklist entries, and revision requests using Odoo sequences.
- **Revision Control**: Only managers can update revision request statuses (`revision_status`).
- **Status Reset**: `Accepted` revision requests automatically reset member status to `Draft`.
- **Duplicate Prevention**: Blocks duplicate pending revision requests for the same blacklist entry.
- **Activity Tracking**: Logs user actions and status changes via `mail.thread` and `mail.activity.mixin`.

---

## 📤 Excel Report (`xlsx_member_report.py`)

- **Endpoint**: `/member/excel/report/<member_ids>`
- **Output**: Generates a formatted Excel file with:
  - English Full Name
  - Arabic Full Name
  - First Name
  - Last Name
  - Status
  - Last Renewal Date
  - Total Last Renewal Order (with currency)
- **Features**:
  - Formatted headers with bold text and background colors.
  - Alternating row colors for readability.
  - Frozen panes for easy navigation.

### Sample Headers:

```
English Full Name | Arabic Full Name | First Name | Last Name | Status | Last Renewal Date | Total Last Renewal Order
```

---

## 📸 PDF Report (`member_report.xml`)

- **Output**: Printable PDF report containing:
  - Member details (English/Arabic names, status, renewal info).
  - Assigned branches with names and locations.
- **Styling**: Uses Bootstrap for a clean, modern, and professional appearance.

---

## 🚀 Future Enhancements

- 🔔 **Email Notifications**: Add automated emails for blacklist and revision updates.
- ⏳ **Blacklist Duration**: Implement duration tracking with automatic expiry.
- 🔎 **Advanced Filters**: Enhance reports with filters for branch, status, or renewal date.
- 📈 **Dashboard Widgets**: Add visual widgets for member counts, blacklist status, and more.
- 📱 **Mobile Optimization**: Improve UI for mobile access via Odoo’s mobile app.

---

## 🧹 Dependencies

- **Odoo Version**: 16 or later
- **Odoo Modules**: `base`, `mail`, `sale`
- **Odoo Features**: `mail.thread`, `ir.model.access`, `ir.rule`, QWeb, Excel reporting

---

## 👤 Author

**Abdelrahman Naser Muhammed**
Front-End & Python Odoo Developer | Cairo, Egypt
📍 [LinkedIn](https://www.linkedin.com/in/abdelrahman-naser-muhammed)
📂 [GitHub](https://github.com/abdonaser)
📧 Email: [abdonaser4223@gmail.com](mailto:abdonaser4223@gmail.com)
