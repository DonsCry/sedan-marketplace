# 🚗 Sedan Marketplace - BMW & Honda (1980-2025)

Aplikasi web full-stack untuk menjual sedan BMW & Honda dari tahun 1980 sampai 2025. Dilengkapi dengan foto berkualitas, pencarian cepat, filter lintas-tahun, UI modern dengan animasi halus, admin panel, dan API RESTful.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Node](https://img.shields.io/badge/node-%3E%3D20.0.0-brightgreen.svg)
![TypeScript](https://img.shields.io/badge/TypeScript-5.3-blue.svg)

## 📋 Daftar Isi

- [Fitur Utama](#-fitur-utama)
- [Tech Stack](#-tech-stack)
- [Prasyarat](#-prasyarat)
- [Instalasi](#-instalasi)
- [Konfigurasi](#-konfigurasi)
- [Menjalankan Aplikasi](#-menjalankan-aplikasi)
- [Database & Seeding](#-database--seeding)
- [API Documentation](#-api-documentation)
- [Deployment](#-deployment)
- [Testing](#-testing)
- [Project Structure](#-project-structure)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Fitur Utama

### Frontend
- ✅ **Katalog Mobil** - Grid cards dengan infinite scroll/pagination
- ✅ **Pencarian Real-time** - Instant search dengan debouncing
- ✅ **Filter Canggih** - Year range, model, price, gearbox, fuel, location
- ✅ **Detail Mobil** - Gallery foto, spesifikasi lengkap, feature list
- ✅ **Compare** - Bandingkan 2-3 mobil side-by-side
- ✅ **Animasi Smooth** - Framer Motion untuk micro-interactions
- ✅ **Responsive Design** - Mobile-first & accessible (a11y)
- ✅ **SEO Optimized** - Meta tags, Open Graph, structured data

### Backend
- ✅ **RESTful API** - Express.js dengan TypeScript
- ✅ **Authentication** - JWT + Refresh Token
- ✅ **Authorization** - Role-based (USER/ADMIN)
- ✅ **File Upload** - Cloudinary integration
- ✅ **Bulk Import** - CSV/JSON import untuk admin
- ✅ **Rate Limiting** - Protection dari abuse
- ✅ **Error Handling** - Centralized error management
- ✅ **Database** - PostgreSQL dengan Prisma ORM

### Admin Panel
- ✅ **CRUD Operations** - Manage cars (create, update, delete)
- ✅ **Multi-image Upload** - Drag & drop dengan preview
- ✅ **Bulk Import** - Upload CSV untuk import massal
- ✅ **Dashboard** - Statistics & analytics

## 🛠 Tech Stack

### Frontend
- **Framework**: Next.js 14 (React 18)
- **Styling**: Tailwind CSS
- **Animation**: Framer Motion
- **State Management**: Zustand
- **Data Fetching**: TanStack Query (React Query)
- **Form Handling**: React Hook Form
- **Icons**: Lucide React
- **HTTP Client**: Axios

### Backend
- **Runtime**: Node.js 20+
- **Framework**: Express.js
- **Language**: TypeScript
- **Database**: PostgreSQL 16
- **ORM**: Prisma
- **Authentication**: JWT (jsonwebtoken)
- **File Upload**: Multer + Cloudinary
- **Validation**: Express Validator
- **Security**: Helmet, CORS, Rate Limiting
- **Cache**: Redis (optional)

### DevOps
- **Containerization**: Docker & Docker Compose
- **CI/CD**: GitHub Actions
- **Testing**: Jest, Supertest, React Testing Library
- **Code Quality**: ESLint, Prettier

## 📦 Prasyarat

Pastikan Anda telah menginstall:

- **Node.js** >= 20.0.0
- **npm** atau **yarn**
- **PostgreSQL** >= 16 (atau gunakan Docker)
- **Redis** (optional, untuk caching)
- **Docker & Docker Compose** (untuk deployment)

## 🚀 Instalasi

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/sedan-marketplace.git
cd sedan-marketplace
```

### 2. Install Dependencies

Menggunakan Makefile (recommended):
```bash
make setup
```

Atau manual:
```bash
# Backend
cd backend
npm install

# Frontend
cd ../frontend
npm install
```

## ⚙️ Konfigurasi

### 1. Environment Variables

#### Backend (`backend/.env`)
```env
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/sedan_marketplace?schema=public"

# JWT
JWT_SECRET="your-super-secret-jwt-key-change-this-in-production"
JWT_REFRESH_SECRET="your-super-secret-refresh-key-change-this-in-production"
JWT_EXPIRES_IN="15m"
JWT_REFRESH_EXPIRES_IN="7d"

# Cloudinary
CLOUDINARY_CLOUD_NAME="your-cloud-name"
CLOUDINARY_API_KEY="your-api-key"
CLOUDINARY_API_SECRET="your-api-secret"

# Redis (optional)
REDIS_URL="redis://localhost:6379"

# Server
PORT=5000
NODE_ENV="development"
FRONTEND_URL="http://localhost:3000"

# Admin Default
ADMIN_EMAIL="admin@sedanmarket.com"
ADMIN_PASSWORD="Admin123!@#"
```

#### Frontend (`frontend/.env.local`)
```env
NEXT_PUBLIC_API_URL=http://localhost:5000/api
```

#### Docker Compose (`.env`)
```env
CLOUDINARY_CLOUD_NAME=your-cloud-name
CLOUDINARY_API_KEY=your-api-key
CLOUDINARY_API_SECRET=your-api-secret
```

### 2. Setup Cloudinary

1. Buat akun di [Cloudinary](https://cloudinary.com/)
2. Dapatkan credentials dari Dashboard
3. Update `.env` dengan credentials Anda

## 🏃 Menjalankan Aplikasi

### Development Mode

#### Menggunakan Makefile:
```bash
make dev
```

#### Manual:

**Terminal 1 - Database (Docker):**
```bash
docker-compose up postgres redis
```

**Terminal 2 - Backend:**
```bash
cd backend
npm run prisma:migrate
npm run dev
```

**Terminal 3 - Frontend:**
```bash
cd frontend
npm run dev
```

Aplikasi akan berjalan di:
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5000
- **API Health**: http://localhost:5000/health

### Production Mode (Docker)

```bash
# Build dan jalankan semua services
make docker-up

# Atau manual
docker-compose up -d

# Lihat logs
docker-compose logs -f

# Stop services
docker-compose down
```

## 🗄️ Database & Seeding

### 1. Run Migrations

```bash
cd backend
npx prisma migrate dev
```

### 2. Seed Database

Seed akan membuat:
- 1 Admin user
- ~100+ mobil BMW & Honda (1980-2025)
- Placeholder images dari Unsplash

```bash
# Menggunakan Makefile
make seed

# Atau manual
cd backend
npm run seed
```

### 3. Prisma Studio (Database GUI)

```bash
make prisma-studio
# Atau
cd backend
npx prisma studio
```

Buka http://localhost:5555

## 📚 API Documentation

### Authentication

#### POST `/api/auth/login`
Login user dan dapatkan access token.

**Request:**
```json
{
  "email": "admin@sedanmarket.com",
  "password": "Admin123!@#"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "accessToken": "eyJhbGc...",
    "refreshToken": "eyJhbGc...",
    "user": {
      "id": "uuid",
      "email": "admin@sedanmarket.com",
      "role": "ADMIN"
    }
  }
}
```

#### POST `/api/auth/register`
Register user baru.

#### POST `/api/auth/refresh`
Refresh access token menggunakan refresh token.

### Cars

#### GET `/api/cars`
Dapatkan daftar mobil dengan filter & pagination.

**Query Parameters:**
- `make` - BMW atau Honda
- `model` - Model mobil (e.g., "3 Series")
- `year_from` - Tahun minimum
- `year_to` - Tahun maksimum
- `price_min` - Harga minimum
- `price_max` - Harga maksimum
- `fuel` - PETROL, DIESEL, HYBRID, ELECTRIC
- `transmission` - MANUAL, AUTOMATIC, SEMI_AUTOMATIC
- `page` - Page number (default: 1)
- `limit` - Items per page (default: 24)
- `sort` - Sort field (default: createdAt)
- `order` - asc atau desc (default: desc)

**Example:**
```
GET /api/cars?make=BMW&year_from=2010&year_to=2020&page=1&limit=24
```

**Response:**
```json
{
  "success": true,
  "data": {
    "cars": [...],
    "pagination": {
      "page": 1,
      "limit": 24,
      "total": 50,
      "totalPages": 3
    }
  }
}
```

#### GET `/api/cars/:id`
Dapatkan detail mobil berdasarkan ID.

#### GET `/api/cars/compare?ids=id1,id2,id3`
Bandingkan 2-3 mobil.

#### POST `/api/cars` (Admin Only)
Tambah mobil baru dengan upload gambar.

**Headers:**
```
Authorization: Bearer <access_token>
Content-Type: multipart/form-data
```

**Form Data:**
- `make` - BMW atau Honda
- `model` - Model name
- `year` - Year (1980-2025)
- `trim` - Trim/variant
- `price` - Price (IDR)
- `mileage` - Mileage (km)
- `location` - Location
- `description` - Description
- `specs` - JSON string of specs
- `fuel` - Fuel type
- `transmission` - Transmission type
- `doors` - Number of doors
- `color` - Color
- `condition` - New/Used/Certified
- `images` - Multiple image files

#### PUT `/api/cars/:id` (Admin Only)
Update mobil.

#### DELETE `/api/cars/:id` (Admin Only)
Hapus mobil.

### Search

#### GET `/api/search?q=keyword&limit=10`
Full-text search mobil.

### Import (Admin Only)

#### POST `/api/imports`
Bulk import mobil dari CSV.

**Headers:**
```
Authorization: Bearer <access_token>
Content-Type: multipart/form-data
```

**Form Data:**
- `file` - CSV file

**CSV Format:**
```csv
make,model,year,trim,price,mileage,location,description,engine,transmission,fuel,doors,color,condition,image_urls
BMW,3 Series,2020,330i,550000000,25000,Jakarta,Description,2.0L Turbo,AUTOMATIC,PETROL,4,Black,Used,url1|url2|url3
```

Template CSV tersedia di: `backend/data/import-template.csv`

#### GET `/api/imports/:id` (Admin Only)
Cek status import.

## 🚢 Deployment

### Deploy ke Vercel (Frontend)

1. Push code ke GitHub
2. Import project di [Vercel](https://vercel.com)
3. Set environment variables:
   - `NEXT_PUBLIC_API_URL`
4. Deploy

### Deploy ke Render/Railway (Backend)

1. Push code ke GitHub
2. Create new Web Service
3. Set environment variables (semua dari `.env`)
4. Set build command: `npm install && npx prisma generate && npm run build`
5. Set start command: `npx prisma migrate deploy && npm start`
6. Deploy

### Deploy dengan Docker

```bash
# Build images
docker-compose build

# Push ke registry (Docker Hub, AWS ECR, etc.)
docker tag sedan-marketplace-backend:latest your-registry/backend:latest
docker push your-registry/backend:latest

docker tag sedan-marketplace-frontend:latest your-registry/frontend:latest
docker push your-registry/frontend:latest

# Deploy ke server
# Copy docker-compose.yml dan .env ke server
# Jalankan:
docker-compose up -d
```

## 🧪 Testing

### Backend Tests

```bash
cd backend
npm test

# Watch mode
npm run test:watch

# Coverage
npm test -- --coverage
```

### Frontend Tests

```bash
cd frontend
npm test

# Watch mode
npm run test:watch
```

### Run All Tests

```bash
make test
```

## 📁 Project Structure

```
sedan-marketplace/
├── backend/
│   ├── prisma/
│   │   └── schema.prisma          # Database schema
│   ├── src/
│   │   ├── config/                # Configuration files
│   │   ├── controllers/           # Route controllers
│   │   ├── middleware/            # Express middleware
│   │   ├── routes/                # API routes
│   │   ├── scripts/               # Utility scripts (seed, etc.)
│   │   ├── utils/                 # Helper functions
│   │   └── server.ts              # Entry point
│   ├── data/
│   │   └── import-template.csv    # CSV import template
│   ├── Dockerfile
│   ├── package.json
│   └── tsconfig.json
│
├── frontend/
│   ├── src/
│   │   ├── app/                   # Next.js app directory
│   │   │   ├── layout.tsx         # Root layout
│   │   │   ├── page.tsx           # Home page
│   │   │   └── globals.css        # Global styles
│   │   ├── components/            # React components
│   │   ├── lib/                   # Utilities & configs
│   │   │   ├── api.ts             # API client
│   │   │   ├── store.ts           # Zustand store
│   │   │   └── utils.ts           # Helper functions
│   │   └── types/                 # TypeScript types
│   ├── public/                    # Static assets
│   ├── Dockerfile
│   ├── next.config.js
│   ├── tailwind.config.ts
│   └── package.json
│
├── .github/
│   └── workflows/
│       └── ci.yml                 # GitHub Actions CI/CD
├── docker-compose.yml             # Docker Compose config
├── Makefile                       # Build automation
├── .env.example                   # Environment template
└── README.md                      # This file
```

## 🔐 Admin Credentials (Default)

**Email:** `admin@sedanmarket.com`  
**Password:** `Admin123!@#`

⚠️ **PENTING:** Ganti password default setelah deployment!

## 📝 API Rate Limits

- **General API**: 100 requests per 15 minutes per IP
- **Auth endpoints**: 5 requests per 15 minutes per IP

## 🎨 Frontend Features Detail

### Animasi & Micro-interactions
- Hover lift pada cards
- Skeleton loading
- Page transitions (fade + slide)
- Toast notifications
- Animated carousel
- Progress bars

### Accessibility
- ARIA labels
- Keyboard navigation
- Color contrast WCAG AA
- Screen reader support

### SEO
- Meta tags optimized
- Open Graph tags
- Structured data (schema.org/Vehicle)
- Sitemap generation
- Image optimization

## 🐛 Troubleshooting

### Database Connection Error
```bash
# Pastikan PostgreSQL berjalan
docker-compose up postgres

# Cek connection string di .env
DATABASE_URL="postgresql://user:password@localhost:5432/dbname"
```

### Prisma Client Error
```bash
# Generate Prisma Client
cd backend
npx prisma generate
```

### Port Already in Use
```bash
# Ganti port di .env atau kill process
# Windows:
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# Linux/Mac:
lsof -ti:5000 | xargs kill -9
```

### Cloudinary Upload Error
- Pastikan credentials benar di `.env`
- Cek quota Cloudinary account
- Pastikan file size < 5MB

## 🤝 Contributing

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **reval** - *Initial work*

## 🙏 Acknowledgments

- BMW & Honda untuk inspirasi
- Unsplash untuk placeholder images
- Community open source

## 📞 Support

Untuk pertanyaan atau dukungan:
- Email: revalsaputra350@gmail.com
- Issues: [GitHub Issues](https://github.com/DonsCry/sedan-marketplace/issues)

---

**Made with ❤️ for sedan enthusiasts**
