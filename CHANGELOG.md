# Changelog

All notable changes to this project are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Versioning follows [Semantic Versioning](https://semver.org/) — `MAJOR.MINOR.PATCH`.

---

## [Unreleased]
**commit: _commit_hash_**

> Changes merged but not yet released.

### Added
-

### Changed
-

### Fixed
-

---

## [2.1.0] — YYYY-MM-DD
**commit: _commit_hash_**

### Added
- New ...  
- Support ...  

### Changed
- ...ed ...
- Increased ...  

### Deprecated
-  ... .Will be deprecated ... 

### Fixed
- Fixed ...

### Security
- Upgraded ...  
---

## [2.0.0] — YYYY-MM-DD
**commit: _commit_hash_**

> ⚠️ **Breaking changes.** See [migration guide](docs/migration-v2.md).

### Breaking Changes
- API base path changed from `/api` to `/v2`
- `user.name` field split into `first_name` and `last_name`
- Auth tokens now expire after 24h (previously 30 days)
- Removed deprecated `POST /auth/login` — use `POST /auth/token`

### Added
- OAuth2 support (Google, GitHub) (#98)
- Webhook delivery with retry logic and delivery logs (#95)
- New `admin` role with expanded permissions (#91)

### Changed
- Password hashing migrated from bcrypt to argon2id (#99)
- All timestamps now returned in ISO 8601 UTC format (#96)

### Removed
- Removed `POST /auth/login` (deprecated since v1.3) (#100)
- Removed `user.full_name` field (use `first_name` + `last_name`) (#97)

---

## [1.3.2] — YYYY-MM-DD

### Fixed
- Fixed 500 error when `metadata` field contains null values (#89)
- Fixed pagination returning incorrect `total` count with filters (#87)

---

## [1.3.1] — YYYY-MM-DD

### Security
- Patched SQL injection vulnerability in search parameter (#85)

---

## [1.3.0] — YYYY-MM-DD

### Added
- `metadata` JSONB field on orders for custom key-value data (#80)
- Bulk create endpoint `POST /orders/bulk` (#78)
- Cursor-based pagination as alternative to offset (#75)

### Deprecated
- `POST /auth/login` — will be removed in v2.0. Use `POST /auth/token`.

### Fixed
- Fixed `DELETE /users/:id` not revoking active sessions (#82)

---

## [1.0.0] — YYYY-MM-DD

### Added
- Initial public release
- User management (CRUD)
- Order management (CRUD)
- JWT authentication
- Pagination on all list endpoints

---


[Unreleased](https://github.com/org/repo/compare/v2.1.0...HEAD)  
[2.1.0] (https://github.com/org/repo/compare/v2.0.0...v2.1.0)
[2.0.0]: https://github.com/org/repo/compare/v1.3.2...v2.0.0
[1.3.2]: https://github.com/org/repo/compare/v1.3.1...v1.3.2
[1.3.1]: https://github.com/org/repo/compare/v1.3.0...v1.3.1
[1.3.0]: https://github.com/org/repo/compare/v1.0.0...v1.3.0
[1.0.0]: https://github.com/org/repo/releases/tag/v1.0.0


<!--
Change types:
  Added      — new features
  Changed    — changes to existing features
  Deprecated — features being removed in a future version
  Removed    — features removed in this version
  Fixed      — bug fixes
  Security   — security patches or vulnerability fixes

Links (update with real URLs):
-->

