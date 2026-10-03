# School360tech Flutter App — Full Development Plan

> **Design inspiration**: SimpliEd (`app.simpliedtech.com`)
> **Architecture source**: `HR360techx/` (Flutter web, Provider, Dio, PHP backend)
> **Shared master DB**: `hr360_master.tenants` — `school_app` flag + `school_db_name` column
> **Brand color**: `Color(0xFF4F46E5)` — indigo-purple
> **Font**: Plus Jakarta Sans (via `google_fonts`)

---

## Implementation Todos (in order)

| # | ID | Task |
|---|---|---|
| 1 | `scaffold` | Flutter create inside School360tech/, configure pubspec.yaml (same deps as HR360techx) |
| 2 | `theme` | app_theme.dart with indigo-purple (#4F46E5) brand, Plus Jakarta Sans, light/dark |
| 3 | `auth-core` | Port auth_models, auth_service, auth_state, session_vault from HR360techx for school roles |
| 4 | `backend-stub` | PHP bootstrap.php + /api/login endpoint for school360_<subdomain> DB |
| 5 | `login-view` | Two-column login page (left form + right illustration) |
| 6 | `main-shell` | ParentShell (top navbar) + AdminShell (left sidebar) with role-based routing |
| 7 | `dashboard-widgets` | NewsCircularsWidget, AttendanceDonutWidget, CalendarWidget, FeedWidget, EventsWidget, TimetableWidget |
| 8 | `dashboard-view` | Assemble parent dashboard_view.dart |
| 9 | `db-schema` | Expand 31_school_schema_stub.sql with all production tables |
| 10 | `support-widget` | Chatwoot + Sleekplan FAB support widget |
| 11 | `my-children` | my_children_view.dart |
| 12 | `child-profile` | child_profile_view.dart (7 tabs) + edit page |
| 13 | `lms` | lms_view.dart + class_detail_view.dart |
| 14 | `timetable` | timetable_view.dart + TimetableGrid widget |
| 15 | `billing` | billing_view.dart + InvoiceCard widget |
| 16 | `attendance` | attendance_view.dart + AttendanceCalendar widget |
| 17 | `extracurricular` | extracurricular_view.dart + course_detail_view.dart + global ToastNotification |
| 18 | `parent-profile` | parent_profile_view.dart + edit_parent_profile_view.dart |
| 19 | `policies` | policies_view.dart + policy_preview_modal.dart |
| 20 | `change-password` | change_password_view.dart |
| 21 | `admin-shell` | AdminShell with collapsible left sidebar (14 nav items) |
| 22 | `admin-dashboard` | KPI cards + charts + recent activity |
| 23 | `admin-students` | DataTable + CRUD + CSV import |
| 24 | `admin-parents` | DataTable + CRUD + link children |
| 25 | `admin-teachers` | DataTable + CRUD + class assignment |
| 26 | `admin-classes` | DataTable + CRUD + student assignment |
| 27 | `admin-timetable` | Editable TimetableGrid per class |
| 28 | `admin-attendance` | Mark attendance per class/date + reports |
| 29 | `admin-lms` | Manage subjects, assignments, gradebook |
| 30 | `admin-billing` | Fee structures + invoice generation + payment tracking |
| 31 | `admin-extracurricular` | Programs, courses, T&C, FAQ, enrollment approval |
| 32 | `admin-announcements` | Compose + publish circulars/news/feed |
| 33 | `admin-events` | Calendar event management |
| 34 | `admin-policies` | Rich-text policy editor + publish/unpublish |
| 35 | `admin-settings` | School profile, academic year, campus, version config |

---

## Directory Layout

```
School360tech/
  lib/
    main.dart
    core/
      auth/          auth_models, auth_service, auth_state, session_vault
      config/        api_config, browser_path stubs
      network/       dio_client.dart
      util/          helpers
    theme/
      app_theme.dart   (purple/indigo brand — #4F46E5 seed)
    models/            student, parent_profile, announcement, event, attendance,
                       timetable_slot, fee_invoice, lms_class, extracurricular_course,
                       policy, notification
    controllers/       app_state.dart, parent_state.dart, admin_state.dart
    shells/
      parent_shell.dart    (top navbar layout)
      admin_shell.dart     (left sidebar layout)
    views/
      login_view.dart
      change_password_view.dart
      parent/
        dashboard_view.dart
        my_children_view.dart
        child_profile_view.dart
        edit_student_profile_view.dart
        lms_view.dart
        class_detail_view.dart
        timetable_view.dart
        billing_view.dart
        attendance_view.dart
        extracurricular_view.dart
        course_detail_view.dart
        parent_profile_view.dart
        edit_parent_profile_view.dart
        policies_view.dart
      admin/
        dashboard_view.dart
        students_view.dart
        parents_view.dart
        teachers_view.dart
        classes_view.dart
        timetable_view.dart
        attendance_view.dart
        lms_view.dart
        billing_view.dart
        extracurricular_view.dart
        announcements_view.dart
        events_view.dart
        policies_view.dart
        settings_view.dart
    widgets/
      shared/
        child_selector_row.dart
        timetable_grid.dart
        attendance_calendar.dart
        toast_notification.dart
        invoice_card.dart
        course_card_widget.dart
        faq_accordion_widget.dart
        policy_card_widget.dart
        policy_preview_modal.dart
      parent/
        school_nav.dart          (top navbar + avatar dropdown)
        news_circulars_widget.dart
        attendance_donut_widget.dart
        calendar_widget.dart
        feed_widget.dart
        upcoming_events_widget.dart
        timetable_widget.dart
        support_chat_button.dart
      admin/
        admin_sidebar.dart
        admin_header.dart
        kpi_card_widget.dart
        data_table_widget.dart
  backend/
    bootstrap.php
    api/
      login.php
      parent/          (parent-facing endpoints)
      admin/           (admin-facing endpoints)
  pubspec.yaml
```

---

## Role-Based Shell Architecture

After login, `AuthState` reads the user's `role` and routes to the correct shell:

```
role == 'parent'      → ParentShell  (top navbar layout)    /parent/*
role == 'admin'       → AdminShell   (left sidebar)          /admin/*
role == 'teacher'     → AdminShell   (left sidebar, reduced nav)
role == 'accountant'  → AdminShell   (left sidebar, billing-only nav)
```

### ParentShell — top horizontal navbar
- Left: School360tech logo
- Center: Home | My Children | LMS | Timetable | Billing | Attendance | Extracurricular
- Right: Bell (unread badge) | Avatar + name + chevron dropdown
- Mobile: collapses to hamburger drawer

### AdminShell — left collapsible sidebar
- Top header: school name/logo | Bell | Avatar dropdown
- Sidebar items: Dashboard | Students | Parents | Teachers | Classes | Timetable | Attendance | LMS | Billing | Extracurricular | Announcements | Events | Policies | Settings
- Sidebar collapsible to icon-only mode

---

## Key Architecture Decisions

- **Platform**: Flutter Web only (`flutter_web_plugins`)
- **State**: `provider` — `AuthState`, `AppState`, `ParentState`, `AdminState`
- **HTTP**: `dio` — JWT Bearer token, stored in `SharedPreferences`/`sessionStorage`
- **Auth flow**: subdomain → `school360_<subdomain>` DB → JWT → role-based shell redirect
- **DB**: Extends `31_school_schema_stub.sql`
- **Roles**: `admin | teacher | student | parent | accountant`

---

## Page Specifications — Parent Portal

---

### Login — `/login`

Two-column, full viewport height.

**Left panel (~330px)**:
- App logo (gem icon + wordmark) — top left
- Heading: "Login" / Subtitle: "Sign in to continue"
- Email field + Password field (👁️ show/hide toggle)
- "Remember me for 30 days" checkbox
- "Log in" button — full-width purple
- "Forgot Password?" link — centered below
- "Download our mobile app..." caption
- Google Play + App Store badges
- `© {year} School360tech. All Rights Reserved.`

**Right panel (flex)**:
- Yellow zigzag decoration (top-left) + purple `+` dots (top-right)
- Headlines: "Student Management" + "+" + **"Learning Management Made Simple."**
- Tagline paragraph
- LMS illustration (woman at desk with monitor)

**Notes**: Chatwoot 😊 button visible on login page too (global, not auth-gated).

---

### Top Navbar (`school_nav.dart`)

- Center links: Home | My Children | LMS | Timetable | Billing | Attendance | Extracurricular
- Bell → slide-in Notifications panel:
  - "Notifications" header + "Mark All As Read"
  - Row: avatar | message | timestamp | red dot (unread)
  - Types: attendance / post / circular
  - "View All Notifications" link at bottom
- Avatar → dropdown:
  - `Version {x.y.z}` (non-clickable label)
  - View My Profile → `/parent/profile/{uuid}`
  - Policies → `/parent/policies`
  - Change Password → `/parent/change-password`
  - Logout → clear JWT + redirect to login

---

### Dashboard — `/parent/home`

- Dismissible greeting banner: "Hey, {name} 👋"
- **Mobile app download banner** (dismissible yellow strip): Google Play + App Store

**3-column responsive grid:**

**Left (wide)**:
- News & Circulars: filter pills (All/News/Circular) + date dropdown (Last 30 Days/7 Days/Today) + horizontal scrollable card carousel. Each card: type badge | campus | title | date | Download button
- Your Feed: post cards with 👍❤️👎 reactions + All/Facebook tab toggle + "Load More"

**Center**:
- Billing mini panel: "No billing data to show" / outstanding amount
- Calendar: mini month grid with event dot indicators + prev/next arrows
- Upcoming Events: date block + event title

**Right (narrow)**:
- Attendance donut: per-child tab (avatar chips), donut chart %, Absent/Present counters
- Timetable: per-child tab, Mon–Fri subject slots

---

### My Children — `/parent/mychildren`

- 2-column card grid
- Each card: circular avatar | name | Roll No. | `{class} | {campus}` | shield icon | "View Profile" purple button
- Data: `students` JOIN `parent_students`

---

### Child Profile — `/parent/child-profile/{uuid}`

**Header (always visible)**:
- Abstract cover banner | circular avatar (camera edit overlay) | name + ✏️ edit icon
- Report button (dropdown: Term 1 / Term 2 → PDF)
- Info row: Roll No. | Grade | Section | Branch | Contact | Admission Date
- Security Deposit box | House badge (colored pill)

**7 tabs**: Overview | Profile | Attendance | TimeTable | Meeting Logs | Letters | Threads

**Tab 1 — Overview** (3-col):
- Attendance donut + Absent/Present counts
- Meeting Logs (empty state or log entries)
- Invoice: invoice#, month pills, amount, Paid badge, fee breakdown tree, payment method
- Below: Parents Info cards | Siblings cards | Documents | Courses (extracurricular enrollments)

**Tab 2 — Profile** (3 cards):
- Personal: Email, Address, Gender, DOB, Place of Birth
- Medical: Blood Group, Special Needs, Academic Support, Food/Medical Allergies
- Gmail Credentials: school email + masked password (👁️ reveal)

**Tab 3 — Attendance**: `AttendanceCalendar` widget (shared)

**Tab 4 — TimeTable**: `TimetableGrid` widget (shared)

**Tab 5 — Meeting Logs**: Academic year + tag filter + search + paginated table

**Tab 6 — Letters**: Academic year filter + search + paginated list

**Tab 7 — Threads**: Two-panel (thread list left | conversation right)

**Edit Student Profile** (`/parent/child-profile/{uuid}/edit`):
- Left: First/Last Name, Email, Recovery Email, Phone (+code), Recovery Phone, Address
- Right: drag-and-drop thumbnail upload (512×512, JPG/PNG, dashed purple border)
- Cancel + Save buttons

---

### LMS — `/parent/lms`

Two top-level tabs: **My Classes** | **My Gradebook**

**My Classes**:
- `ChildSelectorRow` → 4-col class card grid
- Each card: LMS icon | class name | campus | Term pills | student count | teacher | "View Class" button

**Class Detail** (`/parent/class/{uuid}/{tab}`):
- Stream tab: decorative banner + teacher posts (body, attachments, reactions 👍❤️👎, "See More", "Load More")
- People tab: class switcher dropdown + teacher cards
- Classwork tab: banner + assignment list or empty state
- Gradebook tab: Term filter + student score table

**My Gradebook**:
- `ChildSelectorRow` + two-panel: subject list (left, scrollable) | gradebook content (right)
- Term 1 / Term 2 filter above subject list

---

### Timetable — `/parent/timetable`

- `ChildSelectorRow` + `TimetableGrid` (shared widget)
- 5-col Mon–Fri grid
- Rows: Morning Time separator | Period slots | Break separator | more periods
- Period card: Period # | Class | Subject | Section | ⏱ time | Teacher | Room

---

### Billing — `/parent/billing`

- `ChildSelectorRow`
- Red summary bar: `TOTAL OUTSTANDING AMOUNT / PKR {amount}`
- Filter tabs: All {N} | Paid {N} | Unpaid {N} | Expired {N}
- List/grid view toggle
- InvoiceCard: invoice# | month pills (e.g. Aug-26, Sep-26, Oct-26) | date box | amount + status badge | fee breakdown tree (Tuition/Extra Facility/Annual/Security/Late Surcharge) | Amount Paid | payment method

---

### Attendance — `/parent/attendance`

- `ChildSelectorRow` + `AttendanceCalendar` (shared widget)
- 7-col calendar (SUN–SAT), 5 day states: Present (green ✓) | Absent (pink ✗) | Off Day (cream) | Weekend (hatched) | Academic Hold (🔒)
- ⓘ info icon on school days → tap shows punch-in/out tooltip (In: / Out:)
- Legend bar + month navigation arrows

---

### Extracurricular — `/parent/extracurricular`

- `ChildSelectorRow`
- Per child: empty state ("No Courses to show") or program banner + 3-col course card grid
- Course card: illustration | "Enroll" purple badge | name | Program Name | Instructor | Charges | Duration

**Course Detail** (`/parent/course-details/{uuid}/student/{uuid}`):
- Hero gradient banner + "Registration" label + course icon + `PKR {amount}` + "Enroll Now" button
- Metadata grid (2 rows × 4 cols): Program | Start Date | Duration | Grade Range | Instructor | Timings | Days | Location
- Overview description
- 3 T&C checkboxes (all required — error toast if missing)
- FAQ accordion (12 items, collapsed by default)
- Global toast: error (red) / success (green) / info (blue), top-right, auto-dismiss 4s

---

### Parent Profile — `/parent/profile/{uuid}`

3-column layout:
- **Left**: abstract header image | avatar | name | role pill | ✏️ edit | CNIC | Contact | Email | Last Login
- **Center**: 4 tabs (Father Info / Mother Info / Guardian Info / Emergency Contact Info) + Children cards below
- **Right**: Billing summary widget

**Edit Profile** (`/parent/profile-edit/{uuid}`):
- Sections: Father Info | Mother Info | Guardian Info | Emergency Contact
- Each: Name*, Email*, CNIC*, Phone* (+92 dropdown), Occupation, Designation, Company
- Right: avatar upload (file_picker)
- Cancel + Save

---

### Policies — `/parent/policies`

- "Our Policies" heading
- Grouped by category (e.g. Billing)
- 4-col card grid per category
- Card: document thumbnail | 📄 title | date | 👁️ view icon
- Clicking → "Preview Document" modal (scrollable rich text: school crest + title + numbered sections + bullet lists)

---

### Change Password — `/parent/change-password`

- Centered card: 🔒 icon | "Change Password" heading | subtitle
- 3 password fields (Current / New / Confirm), each with 👁️ toggle
- Full-width "Save Password" purple button
- Validation: match check + current password check → success/error toast

---

### Support Widget (global)

Floating 😊 FAB (bottom-right, all pages including login):
- Opens slide-in panel with 3 tabs:
  - **Home**: Chatwoot live chat (self-hosted, Flutter SDK or WebView)
  - **Ideas**: Sleekplan embed (feature requests + voting)
  - **Changelog**: Sleekplan changelog embed

---

## DB Schema — `school360_<subdomain>`

### Core tables
- `users` — id, name, email, password_hash, role, avatar_path, last_login_at
- `campuses` — id, name, location
- `academic_years` — id, label, start_date, end_date, is_current

### Student & Family
- `students` — roll_no, grade, section, campus_id, dob, gender, address, place_of_birth, blood_group, special_needs, food_allergies, medical_allergies, gmail_email, gmail_password_enc, house, security_deposit, admission_date, avatar_path
- `parent_students` — parent_user_id, student_id, relationship
- `parent_profiles` — parent_id, father_name/phone/email/cnic/address/nationality/occupation/designation/company, mother_*, guardian_name/phone/email/relation, emergency_name/phone, avatar_path, last_login_at
- `student_documents` — student_id, file_path, file_name
- `meeting_logs` — student_id, academic_year_id, tag, notes, logged_by, logged_at
- `student_letters` — student_id, academic_year_id, title, content, sent_at
- `threads` + `thread_messages` — student_id messaging system
- `term_reports` — student_id, term, academic_year_id, file_path

### Academics
- `classes` — name, grade, section, campus_id, academic_year_id
- `class_teachers` — class_id, teacher_user_id
- `class_students` — class_id, student_id
- `timetable_slots` — class_id, day_of_week (1–5), period_number, subject, teacher_id, room, start_time, end_time, slot_type (period|morning|break)
- `attendance` — student_id, date, status (present|absent|off_day|academic_hold), punch_in, punch_out
- `stream_posts` + `stream_post_attachments` + `stream_post_reactions`
- `classwork` — class_id, term, title, description, due_date
- `gradebook_entries` — class_id, student_id, term, assignment_name, marks_obtained, max_marks

### Finance
- `fee_invoices` — student_id, invoice_number, status (paid|unpaid|expired), total_amount, amount_paid, receive_date, payment_method (online|otc|cash)
- `invoice_months` — invoice_id, month_year
- `invoice_line_items` — invoice_id, fee_type, amount, label

### Communication
- `announcements` — title, body, type (news|circular), campus_id, target_audience, attachment_path, published_at
- `events` — title, description, location, start_date, end_date, is_all_day, target_audience
- `feed_posts` — title, body, type (facebook|internal), reactions JSON, posted_at
- `notifications` — user_id, type, title, body, ref_id, ref_type, is_read, created_at

### Extracurricular
- `extracurricular_programs` — name, logo_path, campus_id, academic_year_id
- `extracurricular_courses` — program_id, name, illustration_path, description, instructor, charges, duration_months, start_date, timings, days_code, location, grade_from, grade_to
- `extracurricular_terms` — course_id, term_text, sort_order
- `extracurricular_course_faq` — course_id, question, answer, sort_order
- `extracurricular_enrollments` — course_id, student_id, status (enrolled|pending|cancelled), enrolled_at

### Policies
- `policy_categories` — id, name
- `policies` — category_id, title, content (HTML), thumbnail_path, published_at

---

## Admin Panel — Inferred from Parent-Facing Data

| Admin Page | Route | Manages |
|---|---|---|
| Dashboard | `/admin/home` | KPI cards, attendance donut, fee chart, recent activity |
| Students | `/admin/students` | CRUD students, class assignment, CSV import |
| Parents | `/admin/parents` | CRUD parent accounts, link/unlink children |
| Teachers | `/admin/teachers` | CRUD teachers, subject assignment |
| Classes | `/admin/classes` | Grade/section CRUD, class teacher, student roster |
| Timetable | `/admin/timetable` | Editable TimetableGrid per class |
| Attendance | `/admin/attendance` | Mark present/absent/late per class per day |
| LMS | `/admin/lms` | Subjects, stream posts, assignments, gradebook |
| Billing | `/admin/billing` | Fee structures, bulk invoice generation, payment tracking |
| Extracurricular | `/admin/extracurricular` | Programs, courses, T&C, FAQ, enrollment approval |
| Announcements | `/admin/announcements` | Compose/publish news, circulars, feed posts |
| Events | `/admin/events` | Add/edit/delete calendar events |
| Policies | `/admin/policies` | Rich-text policy editor, categories, publish/unpublish |
| Settings | `/admin/settings` | School profile, logo, crest, academic year, campuses, app version |
