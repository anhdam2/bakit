# Làm việc theo module với GitHub

## Mục tiêu của tài liệu này

Tài liệu này hướng dẫn cách dùng BA-kit khi team BA làm việc theo module trên cùng một initiative, với mô hình:

- `BA Lead` chịu trách nhiệm artifact cấp hệ thống và review cuối
- `BA Member` chịu trách nhiệm artifact cấp module
- mỗi người làm trên branch riêng
- mọi thay đổi đi qua Pull Request để lead review

Mô hình này phù hợp khi dự án có nhiều module như `auth-flow`, `payment`, `inventory`, `reporting`.

## Phân vai rõ ràng

### BA Lead

BA Lead chịu trách nhiệm:

- nhận raw input và chốt intake
- khóa scope và engagement mode
- tạo `backbone` cấp hệ thống
- khóa `Portal Matrix`, actor map, global rule, navigation direction
- quyết định module nào được tách cho BA Member
- review PR của BA Member
- điều phối rerun khi requirement thay đổi
- chạy `package` hoặc duyệt package cuối

### BA Member

BA Member chịu trách nhiệm:

- chỉ làm trên module được giao
- bám đúng `backbone` và `plan` đã được lead merge
- tạo hoặc cập nhật artifact trong thư mục module của mình
- mở PR để lead review
- xử lý comment review và cập nhật lại branch

## Quy tắc source of truth

Trong mô hình teamwork, source of truth phải được khóa theo thứ tự:

1. `01_intake/intake.md`
2. `01_intake/plan.md`
3. `02_backbone/backbone.md`
4. `designs/{slug}/DESIGN.md` nếu có UI scope
5. mới đến artifact cấp module trong `03_modules/{module_slug}/`

BA Member không được tự ý redefine:

- global actor
- portal ownership
- menu toàn cục
- shared UX direction
- business rule dùng chung nhiều module

Nếu phát hiện các phần trên cần đổi, BA Member không sửa lặng lẽ trong module mà phải raise lại cho lead để route qua `impact` hoặc update ở `backbone` / `DESIGN.md`.

## Cấu trúc thư mục khi làm việc theo module

```text
plans/{slug}-{date}/
  01_intake/
  02_backbone/
  03_modules/
    auth-flow/
    payment/
    inventory/
  04_compiled/

designs/{slug}/DESIGN.md
```

Artifact cấp module đi đúng thư mục của module đó:

- `frd.md`
- `user-stories.md`
- `srs.md`
- `wireframe-input.md`
- `wireframe-map.md`
- `wireframe-state.md`

## Branching model khuyến nghị

### Branch gốc

- `main`: chỉ chứa nội dung đã review và được merge

### Branch của lead

Lead nên tạo branch riêng để làm phần core artifact đầu tiên, ví dụ:

```text
lead/warehouse-rfp-core
```

Hoặc nếu muốn gắn dated set:

```text
lead/warehouse-rfp-260423-core
```

### Branch của member

Mỗi BA Member làm trên một branch riêng theo module:

```text
ba/warehouse-rfp/auth-flow
ba/warehouse-rfp/payment
ba/warehouse-rfp/inventory
```

Nguyên tắc:

- một branch chỉ gắn với một module chính
- không gom nhiều module vào cùng một PR
- branch của member luôn được tách từ `main` sau khi `backbone` đã merge

## Quy trình làm việc end-to-end

### Bước 1. Lead tạo core artifact

Lead làm trên branch core:

1. chạy `intake`
2. hoàn thiện `plan`
3. chạy `backbone`
4. nếu có UI scope, chốt `DESIGN.md` ở mức hệ thống
5. chia module và giao owner

Kết quả tối thiểu cần merge trước khi BA Member bắt đầu:

- `01_intake/intake.md`
- `01_intake/plan.md`
- `02_backbone/backbone.md`
- `designs/{slug}/DESIGN.md` nếu cần

Lead mở PR vào `main`, tự review hoặc nhờ peer review, rồi merge.

### Bước 2. Lead giao module cho từng member

Mỗi BA Member được giao:

- `slug`
- `date set`
- `module_slug`
- phạm vi artifact phải làm
- deadline
- open questions nếu có

Packet giao việc tối thiểu nên có:

- đường dẫn exact của `backbone.md`
- đường dẫn `plan.md`
- đường dẫn `DESIGN.md` nếu có UI
- module scope cần làm
- out-of-scope rõ ràng

### Bước 3. Member tạo branch và kéo bản mới nhất

Ví dụ:

```bash
git checkout main
git pull origin main
git checkout -b ba/warehouse-rfp/auth-flow
```

Sau đó member chỉ làm trong phạm vi:

```text
plans/{slug}-{date}/03_modules/auth-flow/
```

### Bước 4. Member tạo artifact cấp module

Tùy scope được giao, member chạy:

- `frd`
- `stories`
- `srs`
- `wireframes`

Ví dụ trong Claude Code:

```text
/ba-start frd --slug warehouse-rfp --module auth-flow
/ba-start stories --slug warehouse-rfp --module auth-flow
/ba-start srs --slug warehouse-rfp --module auth-flow
```

Ví dụ trong Codex:

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Run stories for slug warehouse-rfp module auth-flow.
Read only the resolved backbone and module prerequisites.
Do not scan unrelated modules.
```

Member phải tuân thủ:

- không sửa module khác
- không sửa `02_backbone` trừ khi lead yêu cầu
- không tự thêm global navigation hoặc shared rule mới
- nếu có thay đổi requirement, route qua `impact` thay vì tự sửa toàn bộ chuỗi artifact

### Bước 5. Member tự kiểm tra trước khi mở PR

Trước khi mở PR, member nên tự check:

- artifact nằm đúng thư mục module
- acceptance criteria có đủ
- không có mâu thuẫn với `backbone`
- nếu có screen/UI, screen ID và handoff artifact nhất quán
- không chạm file ngoài module nếu chưa được giao

### Bước 6. Member mở Pull Request

PR title nên dùng format rõ ràng, ví dụ:

```text
docs(auth-flow): add FRD, stories, and SRS for warehouse-rfp
```

PR description nên có:

- module đang làm
- artifact đã thêm hoặc sửa
- assumption
- open questions
- phần cần lead review kỹ

Mẫu PR description ngắn:

```text
Scope:
- module: auth-flow
- slug: warehouse-rfp

Artifacts:
- frd.md
- user-stories.md
- srs.md

Notes:
- no backbone change
- no shared navigation change
- waiting lead confirm audit-log wording in UC-03
```

### Bước 7. Lead review PR

Lead review theo checklist:

- có đúng module scope không
- có đụng artifact hệ thống không
- có mâu thuẫn với backbone hoặc DESIGN.md không
- rule code / message code có đụng module khác không
- use case, AC, screen behavior có trace được không

Lead có thể:

- approve để merge
- request changes nếu artifact chưa đủ chuẩn
- yêu cầu route `impact` nếu change thực chất là đổi scope chung

### Bước 8. Merge vào main

Khi PR đạt chuẩn:

1. member rebase hoặc update branch nếu cần
2. lead hoặc repo maintainer merge PR vào `main`
3. các member khác pull lại `main` trước khi tiếp tục

Khuyến nghị:

- dùng squash merge nếu muốn lịch sử gọn
- dùng merge commit nếu muốn giữ nguyên commit history theo module

### Bước 9. Lead chạy package hoặc final review

Sau khi các module quan trọng đã merge, lead chạy:

- `status` để xem artifact set hiện tại
- `package` để compile HTML

Nếu có nhiều module song song, chỉ lead hoặc người được lead ủy quyền mới nên chạy package cuối.

## Khi nào member được phép sửa core artifact

Mặc định: không.

Chỉ cho phép khi:

- lead giao explicit task sửa `backbone`
- hoặc PR của member được tách riêng cho `backbone` / `DESIGN.md`

Không nên gộp trong cùng một PR:

- thay đổi `02_backbone`
- thay đổi `03_modules/{module_slug}`

Nếu vừa đổi system-level vừa đổi module-level, nên tách 2 PR:

1. PR core artifact
2. PR module artifact rebase trên PR core đã merge

## Xử lý requirement change khi team đang làm song song

Nếu có change mới khi nhiều member đang làm:

1. lead chạy `impact`
2. lead xác định affected artifacts
3. lead thông báo module nào bị ảnh hưởng
4. member chỉ rerun phần module bị ảnh hưởng
5. nếu change chạm `backbone`, merge core change trước rồi member mới cập nhật branch của mình

Điều này tránh việc mỗi module tự diễn giải change theo cách khác nhau.

## Phân quyền GitHub khuyến nghị

### Mô hình quyền đơn giản

Nếu repo nằm trong GitHub Organization, nên dùng team + repository roles.

Khuyến nghị:

| Nhóm | GitHub role |
| --- | --- |
| `ba-leads` | `Maintain` hoặc `Admin` |
| `ba-members` | `Write` |
| `stakeholders-review` | `Triage` hoặc `Read` |

Giải thích:

- `Write` đủ để member push branch và mở PR
- `Maintain` phù hợp cho lead nếu cần quản lý repo nhưng không cần toàn quyền phá hủy
- `Admin` chỉ nên dành cho owner hoặc người quản trị repo

### Cách phân quyền trên GitHub theo từng bước

Nếu repo nằm trong GitHub Organization, repo owner hoặc admin có thể cấu hình như sau:

1. Vào `Organization` hoặc `Repository`.
2. Mở phần `Teams` hoặc `Collaborators and teams`.
3. Tạo các team:
   - `ba-leads`
   - `ba-members`
   - team module nếu cần như `ba-auth`, `ba-payment`
4. Gán quyền repo:
   - `ba-leads` = `Maintain`
   - `ba-members` = `Write`
   - stakeholder reviewer = `Triage` hoặc `Read`
5. Kiểm tra lại member đã có thể:
   - pull code
   - push branch riêng
   - mở PR
   - comment review

Nếu repo chưa dùng Organization, có thể gán quyền trực tiếp cho từng collaborator. Tuy vậy, dùng team sẽ dễ scale hơn khi số BA tăng.

### Branch protection cho `main`

Khuyến nghị bật branch protection hoặc ruleset cho `main` với các rule sau:

- yêu cầu pull request trước khi merge
- yêu cầu ít nhất 1 approval
- yêu cầu code owner approval nếu dùng `CODEOWNERS`
- dismiss stale approvals khi có commit mới
- chặn force push
- chặn delete branch chính

Nếu team chặt hơn, có thể thêm:

- require conversation resolution
- require status checks
- require linear history

### Cách bật branch protection hoặc ruleset

Trên GitHub, repo admin hoặc maintainer có thể làm như sau:

1. Vào `Settings`.
2. Mở `Rules` hoặc `Branches` tùy UI hiện tại.
3. Tạo rule hoặc ruleset áp vào branch `main`.
4. Bật các tùy chọn:
   - require a pull request before merging
   - require approvals
   - require review from code owners nếu dùng `CODEOWNERS`
   - dismiss stale approvals
   - block force pushes
   - block deletion
5. Lưu rule và thử mở một PR test để xác nhận behavior.

### CODEOWNERS khuyến nghị

Nếu muốn lead luôn được request review cho artifact BA, có thể thêm `.github/CODEOWNERS` như sau:

```text
/.github/ @org/ba-leads
/plans/ @org/ba-leads
/designs/ @org/ba-leads
/plans/**/03_modules/auth-flow/ @org/ba-leads @org/ba-auth
/plans/**/03_modules/payment/ @org/ba-leads @org/ba-payment
```

Ý nghĩa:

- mọi thay đổi BA artifact đều kéo review của lead
- module quan trọng có thể kéo thêm đúng team phụ trách module đó

### Cách thêm CODEOWNERS

1. Tạo file `.github/CODEOWNERS`.
2. Thêm rule owner cho `plans/`, `designs/`, và các module quan trọng.
3. Commit file này vào `main`.
4. Đảm bảo branch protection đã bật `require review from code owners`.
5. Mở một PR test để kiểm tra lead có được auto-request review hay không.

### Team structure khuyến nghị trên GitHub

Nếu dùng GitHub Organization, nên tạo:

- team `ba-leads`
- team `ba-members`
- team module nếu cần, ví dụ `ba-auth`, `ba-payment`

Phân quyền đơn giản:

1. gán `ba-leads` quyền `Maintain`
2. gán `ba-members` quyền `Write`
3. dùng `CODEOWNERS` để ép review đúng người

### Cấu hình PR review thực tế

Team BA nhỏ có thể dùng:

- 1 approval bắt buộc
- reviewer mặc định là lead
- squash merge

Team BA lớn hơn có thể dùng:

- 1 lead approval bắt buộc
- code owner approval
- module team review optional
- ruleset riêng cho `main`

## Checklist cho BA Lead

- intake, plan, backbone đã được merge trước chưa
- module owner đã được giao rõ chưa
- mỗi PR có đúng một module chính không
- không có module nào redefine system-level decision
- impact change đã được xử lý tập trung chưa
- package cuối do đúng người chạy chưa

## Checklist cho BA Member

- đã branch từ `main` mới nhất chưa
- đã xác nhận đúng `slug`, `date`, `module` chưa
- chỉ sửa trong module mình được giao chưa
- nếu có change request, đã route `impact` chưa
- PR description đã ghi rõ assumption và open questions chưa

## Mẫu operating policy ngắn cho team

Anh có thể copy policy này vào README nội bộ hoặc GitHub repo guide:

```text
1. BA Lead phải merge intake, plan, backbone trước khi BA Member làm module.
2. Mỗi BA Member chỉ làm trên một module branch riêng.
3. Không sửa system-level artifact trong PR module.
4. Mọi thay đổi scope hoặc rule dùng chung phải đi qua impact.
5. Mọi thay đổi vào main phải đi qua Pull Request và lead review.
6. Package cuối chỉ chạy sau khi các PR module chính đã merge.
```

## Tài liệu GitHub nên đọc thêm

- Repository roles: https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles/repository-roles-for-an-organization
- Branch protection: https://docs.github.com/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule
- CODEOWNERS: https://docs.github.com/articles/about-code-owners

Lưu ý: GitHub có thể thay đổi UI theo plan hoặc theo loại account, nhưng các khái niệm cốt lõi phía trên là mô hình triển khai ổn định và phù hợp với BA-kit hiện tại.
