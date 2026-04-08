# BA-kit - Nền Tảng Phân Tích Nghiệp Vụ Cơ Động (Cho AI Agents)

BA-kit là một bộ công cụ phân tích nghiệp vụ (Business Analysis) dành cho môi trường agentic coding. Quên đi việc viết prompt nhắc nhở từng ly từng tí, BA-kit trang bị sẵn cho AI Agent mô hình quy trình chuẩn, các vai trò đặc vụ (agent roles), quy định xuất file (templates), và bộ luật thẩm định chất lượng.

Hệ thống được thiết kế hoàn hảo để chạy nguyên bản (native) hoặc tích hợp chéo dự án trên 3 môi trường AI Agents chính: **Claude Code**, **Codex**, và **Antigravity**.

---

## Tính Năng Toàn Diện

- **Automatic BA Routing**: Agent của bạn giờ đây hiểu ngôn ngữ tự nhiên. Việc của bạn chỉ là ra lệnh (VD: "Phân tích gap con app báo cáo này").
- **Vòng Đời Hoàn Chỉnh (Lifecycle)**: Intake form $\rightarrow$ Gap analysis $\rightarrow$ Requirements Backbone $\rightarrow$ Stories / FRD $\rightarrow$ SRS $\rightarrow$ Wireframes. Bạn không lo bị thiếu sót luồng công việc.
- **Triage Impact**: Đang phân tích mà mọc ra rule mới? Hệ thống chặn ngay để đánh giá rủi ro trước khi đè dữ liệu tào lao vào file dự án.

---

## Hướng Dẫn Cài Đặt Chi Tiết Cho 3 Môi Trường

BA-kit hoạt động tốt nhất khi được gắn đúng cách vào nền tảng bạn sử dụng. Lưu ý, có 2 kiểu sử dụng chung:
- **Dùng tại chỗ (In-situ):** Mở IDE / Terminal ngay thư mục BA-kit để thao tác thử nghiệm học hỏi.
- **Tích hợp vào dự án khác (Cross-repo):** Mồi toàn bộ bộ tính năng BA-kit vào một mã nguồn dự án (Codebase) phần mềm có sẵn của công ty, để AI vừa Code vừa làm BA ở đó. (Xem hướng dẫn cụ thể ở bên dưới).

---

### 1. Dành cho Claude Code

Claude Code sở hữu cơ chế lệnh gạch chéo trực tiếp (Native Slash Commands như `/ba-start`). Để có sức mạnh này, bộ cài sẽ "bơm" BA-kit vào lõi `~/.claude/` của hệ thống.

**Cách Cài Đặt Chung:**
1. Tải BA-kit về một thư mục bất kỳ:
   ```bash
   git clone https://github.com/anhdam2/bakit.git
   cd bakit
   ```
2. Chạy file installer:
   ```bash
   ./install.sh
   ```
   *Giải thích: Script sẽ tự động chép các folder `skills/`, `agents/`, `rules/`, `templates/` vào thư mục `~/.claude/` của ứng dụng và cập nhật tiện ích CLI `ba-kit` vào `~/.local/bin`.*
3. Khởi động lại Claude Code.

**Cách Tích Hợp Để Làm BA Trên Folder Dự Án Khác:**
Vì toàn bộ công cụ đã được bơm vào máy tính ở bước cài đặt, nên bạn chỉ đem theo chất xám của BA-kit đi khắp nơi.
1. Khởi chạy IDE và mở folder dự án phần mềm của bạn.
2. Sao chép riêng tệp `CLAUDE.md` từ kho BA-kit bỏ vào gốc dự án của bạn (Tệp này giúp Claude tại dự án biết cần ứng xử như một BA).
3. Triển khai lệnh tiếng Việt bình thường:
   ```text
   Phân tích yêu cầu quản lý nhân sự từ file docs/yeucau.pdf
   ```
   Hoặc gọi trực tiếp thông qua gạch chéo:
   ```text
   /ba-start
   /ba-start backbone --slug hr-app
   /ba-start status --slug hr-app
   ```

---

### 2. Dành cho Codex

Codex tích hợp Agent tự nhiên dựa trên file bộ não `AGENTS.md` tại cấp độ cài đặt project (Project-level).

**Cách Cài Đặt Chung:**
Mở thư mục `BA-kit`, Codex sẽ tự nhìn thấy `AGENTS.md` và chạy được ngay.
Tuy nhiên, nếu muốn Codex lưu mãi mãi vào não nó, hãy cài manifest:
```bash
bash scripts/install-codex-ba-kit.sh
```

**Cách Tích Hợp Để Làm BA Trên Folder Dự Án Khác (Cực kỳ quan trọng):**
Khác với Claude, Codex cần một bộ tài liệu mang tính "di động" ngay trong thư mục đang code.
1. Từ repo BA-kit gốc, hãy copy toan bộ hệ thư mục: `skills/`, `rules/`, `templates/` và đặc biệt là file `AGENTS.md` vào trực tiếp thư mục dự án của công ty bạn.
2. Mở dự án đó trong Codex. Bộ định tuyến trong tệp `AGENTS.md` sẽ đánh thức tính năng BA.
3. Gõ chat giao việc tự do để nó định tuyến:
   ```text
   Thêm yêu cầu audit log cho project warehouse-rfp
   (*Hệ thống Codex lập tức tự tìm file skills và kích hoạt lệnh ba-start impact*)

   Chạy xây dựng SRS đầy đủ cho ứng dụng này.
   ```

---

### 3. Dành cho Antigravity (Google DeepMind)

Antigravity là nền tảng tối tân có khái niệm Bộ nhớ Kiến Thức (Knowledge Items - KIs), giúp nó quản lý luồng BA-kit xuyên qua nhiều phiên dự án mượt mà. Nó sử dụng tệp lệnh `GEMINI.md`.

**Cách Cài Đặt Chung:**
1. Khởi động terminal ở repo BA-kit, chạy lệnh cài đặt để Antigravity ghi bộ KI BA-kit vào não bộ `~/.gemini/antigravity/` của nó:
   ```bash
   bash scripts/install-antigravity-ba-kit.sh
   ```
2. Lệnh này cũng cài đặt CLI `ba-kit` (giống phần Claude) để bạn dễ nhận update.

**Cách Tích Hợp Để Làm BA Trên Folder Dự Án Khác:**
1. Nhờ bước ghi KI ở trên, Antigravity đã "nắm luật" BA-kit. 
2. Mở IDE tại một dự án code mới tinh của bạn.
3. Chỉ cần sao chép 2 tệp `GEMINI.md` và `AGENTS.md` vào gốc dự án mới này. Sự tồn tại của file `GEMINI.md` đóng vai trò "kích hoạt đánh thức" các KIs BA-kit của Antigravity. Nếu không copy sang, Antigravity sẽ chạy như 1 coder bình thường.
4. (Nâng cao): Nếu dự án đó cần tùy biến mẫu FRD và SRS biểu mẫu của riêng công ty bạn, hãy copy thêm cụm `templates/` và `skills/` vào dự án đó để Antigravity ưu tiên theo format nội bộ (Workspace override).
5. Gõ lệnh tự nhiên:
   ```text
   Đọc requirements trong docs/baocao.docx và chạy nguyên một quy trình full workflow.
   ```
   Hoặc can thiệp luồng:
   ```text
   Read skills/ba-start/SKILL.md and run impact cho slug warehouse-rfp.
   ```

---

## Nâng Cấp Hệ Thống

Để dễ dàng nâng cấp bộ kĩ năng / templates từ GitHub theo thời gian:
Mở terminal và gõ:
```bash
ba-kit update
ba-kit doctor
```

*(Lệnh cập nhật sẽ tự động tìm các hệ máy đang cài (Claude/Codex/Antigravity) và refresh chúng, giữ nguyên an toàn cho dữ liệu dự án của bạn).* 
