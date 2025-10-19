# ☕ Coffee Drop App

A comprehensive full-stack coffee ordering application with customer-facing features, profile management, and a powerful administrative dashboard built with Supabase backend.

---

## 📋 Project Overview

This application provides a complete coffee shop experience, enabling users to browse products, customize orders, manage delivery addresses, and track their purchases in real-time. The system includes a robust admin panel for business analytics, inventory management, and product operations.

The project addresses the modern demand for seamless mobile ordering experiences, offering features like social authentication, secure payment processing, and multi-language support to serve a diverse customer base.

---

## ✨ Key Features

- **Admin Dashboard:** Comprehensive analytics with revenue tracking, sales trends, and growth metrics.
- **Secure Authentication:** Multi-provider login support (Email/Password, Google, Facebook) powered by Supabase Auth with email verification workflows.
- **Smart Product Catalog:** Dynamic search and filtering across categories with real-time product availability status.
- **Advanced Customization:** Size variants, quantity controls, and personalized order configurations stored as JSON.
- **Profile Management:** User profile customization with avatar upload, email/password updates, and preference settings.
- **Payment Integration:** Secure Stripe tokenization for card payments with Cash on Delivery (COD) option.
- **Location Services:** Interactive map-based address selection with coordinate capture and multiple saved addresses.
- **Real-time Notifications:** Non-intrusive feedback for all user actions and system events.
- **Multi-language Support:** Built-in localization for English, العربية, Español, Français, and Italiano.
- **Inventory Management:** Real-time stock monitoring with color-coded status indicators and bulk variant editing.

---

## 🚀 How It Works

The system operates on a secure client-server architecture with Supabase backend:

**Authentication Layer:** Users sign up or log in using Supabase Auth, which creates a secure session and profile entry.

**Product Discovery:** The app fetches products from the `products` table, displaying them with category filters and search capabilities.

**Order Customization:** Users select size variants and quantities, which are stored locally in the cart with customizations in JSON format.

**Checkout Flow:** Users select a delivery address from saved locations and choose a payment method (Stripe-tokenized cards or COD).

**Order Processing:** Upon checkout, the system creates records in the `orders` and `order_items` tables, calculating totals with discounts and shipping.

**Admin Operations:** Admin users access the dashboard to view analytics, manage inventory stock levels, and add new products with multiple variants.

**Security:** Row Level Security (RLS) policies ensure users can only access their own data, while admins have elevated permissions for management functions.

---

## 🛠️ Technologies Used

**Backend (Supabase)**
- **Supabase Auth:** Handles user authentication, email verification, and password reset workflows.
- **PostgreSQL Database:** Stores all application data with tables for profiles, products, orders, order_items, and addresses.
- **Row Level Security (RLS):** Enforces data access policies at the database level for maximum security.
- **Real-time Subscriptions:** Enables live updates for order status and inventory changes.

**Payment Processing**
- **Stripe API:** Tokenizes payment methods securely, storing only payment method IDs in the database.
- **Cash on Delivery:** Alternative payment option for users preferring offline transactions.

**Location Services**
- **Interactive Maps:** Map integration for address selection with coordinate capture (latitude/longitude).
- **Geocoding:** Converts map coordinates to human-readable addresses for storage.

**Localization**
- **Multi-language Support:** Persistent language preference stored in `profiles.preferred_language` field.
- **Supported Languages:** English, Arabic (العربية), Spanish (Español), French (Français), Italian (Italiano).

---

## 🗃️ Database Schema

<img width="1691" height="745" alt="supabase-schema-fxwpkhftzlintbdkujze" src="https://github.com/user-attachments/assets/7cf5dde6-165b-4dc4-9774-98ba04e765cc" />

### Core Tables

**auth.users** (Managed by Supabase Auth)

**profiles**

**products**

**orders**

**order_items**

**addresses**

---

## 🔐 Security & Validation

**Authentication Rules**
- Password requirements: ≥8 characters, ≥1 uppercase letter, ≥1 number
- Email verification required for new accounts
- Password reset via deep link or 6-digit verification code
- Social OAuth tokens managed securely by Supabase

**Row Level Security (RLS) Policies**
- **profiles:** Users can only READ/WRITE their own profile data
- **products:** Public READ access; Admin-only CREATE/UPDATE/DELETE
- **orders:** Users can only READ/WRITE their own orders; Admin has full READ access
- **order_items:** Access restricted to related order owners and admins
- **addresses:** Users can only READ/WRITE their own addresses

**Payment Security**
- Card details never stored in database
- Stripe tokenization creates secure payment method IDs
- PCI compliance through Stripe's secure infrastructure

---

## 👤 User Flows

### Customer Journey

1. **Onboarding:** Sign up with email or social login → Email verification → Profile setup
2. **Shopping:** Browse catalog → Search/filter products → View product details
3. **Ordering:** Customize size/quantity → Add to cart → Review cart
4. **Checkout:** Select delivery address → Choose payment method → Place order
5. **Tracking:** Receive order confirmation → Track delivery status

### Admin Operations

1. **Dashboard Access:** Login as admin user (is_admin: true) → Enable admin mode toggle
2. **Analytics:** View revenue metrics → Analyze sales trends → Monitor growth indicators
3. **Inventory:** Check stock levels → Update product availability → Adjust pricing
4. **Product Management:** Add new products → Define variants → Set stock quantities

---

## 📱 Key Screens

### Authentication Screens
- Get Started Now (Sign Up)
- Welcome Back (Login)
- Reset Password
- Enter Verification Code
- Set New Password

### Customer Screens
- Home (Product Catalog)
- Product Details
- Cart & Order Summary
- Checkout
- Payment Methods
- Saved Addresses
- Add New Address (Map + Form)

### Profile & Settings
- Profile Overview
- Edit Profile Details
- Change Email
- Reset Password (Logged In)
- Language Settings

### Admin Screens
- Analytics Dashboard
- Stock Manager
- Add Product

---

## 💳 Payment & Shipping

**Payment Options**
- Credit/Debit Cards (via Stripe)
- Cash on Delivery (COD)

**Shipping Calculation**
- Flat rate: 3.60 EGP
- Applied to all orders regardless of location

**Order Calculation**
```
Sub Total = Σ (unit_price × quantity)
Discount = Applied promotional discounts
Shipping = 3.60 EGP (flat rate)
Total Price = Sub Total - Discount + Shipping
```

---

## 🌍 Localization

The app supports five languages with persistent user preferences:

- 🇬🇧 English (en)
- 🇸🇦 العربية (ar)
- 🇪🇸 Español (es)
- 🇫🇷 Français (fr)
- 🇮🇹 Italiano (it)

Language selection updates immediately without requiring app restart, and the preference is saved to the user's profile.

---

## 📊 Admin Analytics

**Key Performance Indicators (KPIs)**
- Total Revenue
- Customer Count
- Products Sold
- Growth Percentage (with trend indicators)

**Sales Trend Visualization**
- Interactive line chart
- Selectable time periods: Daily, Weekly, Monthly
- Real-time data from orders table

---

## 🔔 Notification System

**Snackbar Types & Use Cases**

**Success** (Green)
- Profile details saved
- Order placed successfully
- Address saved
- Payment method added

**Error** (Red)
- Login failed
- Invalid credentials
- Network errors
- Payment processing failed

**Warning** (Orange)
- Username unavailable
- Form validation errors
- Stock limitations

**Info** (Blue)
- Verification code sent
- Email update pending
- General system notifications

---

## 🎨 Design Principles

- **Clean & Modern UI:** Intuitive navigation with minimal learning curve
- **Responsive Feedback:** Immediate visual confirmation for all user actions
- **Accessibility:** High contrast, readable fonts, and clear call-to-action buttons
- **Performance:** Optimized queries and caching for fast load times
- **Security-First:** All sensitive operations require authentication and validation

---

## 📱 Download & Try It Now

### Latest Release: v1.0.0

**Download the Android APK:**
- [CoffeeDrop.apk](https://github.com/ahmed-ashraf-refaee/coffee_app/releases/download/v1.0.0/CoffeeDrop.apk) (Direct Download)
- [View Release Notes](https://github.com/ahmed-ashraf-refaee/coffee_app/releases/tag/v1.0.0)

---

## 🚧 Setup & Installation

### Prerequisites
- Supabase account and project
- Stripe account for payment processing
- Map service API key for address selection

### Configuration Steps

1. **Clone the repository**
```bash
git clone https://github.com/ahmed-ashraf-refaee/coffee_app.git
cd coffee_app
```

2. **Configure Supabase**
- Create tables using the schema provided in `/database/schema.sql`
- Set up RLS policies from `/database/rls-policies.sql`
- Update environment variables with your Supabase URL and anon key

3. **Configure Stripe**
- Add your Stripe publishable key to the environment variables
- Set up webhook endpoints for payment confirmations

4. **Set up authentication providers**
- Enable Email/Password auth in Supabase dashboard
- Configure Google OAuth credentials
- Configure Facebook OAuth credentials

5. **Deploy and test**
- Run database migrations
- Test authentication flows
- Verify payment integration
- Test admin panel access

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## 📧 Support

For support inquiries, please contact the development team or open an issue in the GitHub repository.
