# Pencil Artifacts

Use this directory for Pencil wireframe artifacts that support SRS screen specifications.

## Convention

- Store `.pen` files under `designs/`
- Prefer one subdirectory per initiative or product area
- Prefer one artifact per flow, module, or coherent screen pack
- Allow one `.pen` file to contain multiple frames
- Prefix each screen frame with its SRS screen ID, for example `SCR-01 - Login`

Example paths:
- `designs/customer-portal/auth-flow.pen`
- `designs/customer-portal/dashboard-core.pen`
- `designs/customer-portal/exports/auth-flow/SCR-01-login.png`

## Usage

- Link each SRS screen section to the relevant `.pen` artifact and exact frame
- Keep screen IDs aligned between the SRS and Pencil frame names
- Use the `.pen` file as the low-fidelity wireframe source of truth

## Notes

- Pencil is used here for wireframes only, not design-to-code generation
- If a single `.pen` file covers multiple screens, list the covered screen IDs in the SRS and identify the target frame per screen
