Return-Path: <linux-s390+bounces-8182-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B912AA09818
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jan 2025 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E74188EA71
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jan 2025 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC22212D70;
	Fri, 10 Jan 2025 17:07:37 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5715028C;
	Fri, 10 Jan 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736528857; cv=none; b=DDCRZs6HgZ1b1egLi7VRDDDAxV7XCaARdEFvpYxdCBRTDVvFfOi2zI4UmfeN5RN8a1s2kaabxUBNGdolVMF2SGa9m2br8ojcdZrzaZ0gXi6Kt2XXy7kFB3auk2OoT/48b+aGIzgwY0WyQNVJj7LvxMUDjHdGbKrT74iL1GReRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736528857; c=relaxed/simple;
	bh=Uaqs/Z5Heg/5SG6PR8vN/lLuEnnnlSUjn6DFld7+VuM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gc/fZk1Li+TlQehQnzYB6Q/0Bg4EHsnZ21/Tu56GGAzmF0YOH+z92fToeRCdUZBpVJlfoL6oVg/SZACTiJ7JU/wYD+usNl0wnvdKWEODjJJwHu/YemFDhf3PXGvgRAwtBnFMGcB+QrLWq9yrG9i1z7/3F4Hj3lXVHCEJA4mLXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ACCC4CEE0;
	Fri, 10 Jan 2025 17:07:35 +0000 (UTC)
Date: Fri, 10 Jan 2025 12:09:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon 
 <will@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Masami Hiramatsu 
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu 
 Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds 
 <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily
  Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH v2] arm64: scripts/sorttable: Implement sorting mcount_loc
 at boot for arm64
Message-ID: <20250110120911.76e8f786@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The mcount_loc section holds the addresses of the functions that get
patched by ftrace when enabling function callbacks. It can contain tens of
thousands of entries. These addresses must be sorted. If they are not
sorted at compile time, they are sorted at boot. Sorting at boot does take
some time and does have a small impact on boot performance.

x86 and arm32 have the addresses in the mcount_loc section of the ELF
file. But for arm64, the section just contains zeros. The .rela.dyn
Elf_Rela section holds the addresses and they get patched at boot during
the relocation phase.

In order to sort these addresses, the Elf_Rela needs to be updated instead
of the location in the binary that holds the mcount_loc section. Have the
sorttable code, allocate an array to hold the functions, load the
addresses from the Elf_Rela entries, sort them, then put them back in
order into the Elf_rela entries so that they will be sorted at boot up
without having to sort them during boot up.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20250107083214.5a29d429@gandalf.local.home/

- Rebased on top of: https://lore.kernel.org/all/20250110075459.13d4b94c@gandalf.local.home/

- Added check against Elf_Rela info filed to make sure it matches "0x403"

 arch/arm64/Kconfig  |   1 +
 scripts/sorttable.c | 181 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 100570a048c5..e922622a9571 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -214,6 +214,7 @@ config ARM64
 		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
+	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 9f41575afd7a..f75be83916a8 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -28,6 +28,7 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
@@ -79,10 +80,16 @@ typedef union {
 	Elf64_Sym	e64;
 } Elf_Sym;
 
+typedef union {
+	Elf32_Rela	e32;
+	Elf64_Rela	e64;
+} Elf_Rela;
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
+static void (*w8)(uint64_t, uint64_t *);
 typedef void (*table_sort_t)(char *, int);
 
 static struct elf_funcs {
@@ -102,6 +109,10 @@ static struct elf_funcs {
 	uint32_t (*sym_name)(Elf_Sym *sym);
 	uint64_t (*sym_value)(Elf_Sym *sym);
 	uint16_t (*sym_shndx)(Elf_Sym *sym);
+	uint64_t (*rela_offset)(Elf_Rela *rela);
+	uint64_t (*rela_info)(Elf_Rela *rela);
+	uint64_t (*rela_addend)(Elf_Rela *rela);
+	void (*rela_write_addend)(Elf_Rela *rela, uint64_t val);
 } e;
 
 static uint64_t ehdr64_shoff(Elf_Ehdr *ehdr)
@@ -262,6 +273,41 @@ SYM_ADDR(value)
 SYM_WORD(name)
 SYM_HALF(shndx)
 
+#define RELA_ADDR(fn_name)				\
+static uint64_t rela64_##fn_name(Elf_Rela *rela)	\
+{							\
+	return r8((uint64_t *)&rela->e64.r_##fn_name);	\
+}							\
+							\
+static uint64_t rela32_##fn_name(Elf_Rela *rela)	\
+{							\
+	return r((uint32_t *)&rela->e32.r_##fn_name);	\
+}							\
+							\
+static uint64_t rela_##fn_name(Elf_Rela *rela)		\
+{							\
+	return e.rela_##fn_name(rela);			\
+}
+
+RELA_ADDR(offset)
+RELA_ADDR(info)
+RELA_ADDR(addend)
+
+static void rela64_write_addend(Elf_Rela *rela, uint64_t val)
+{
+	w8(val, (uint64_t *)&rela->e64.r_addend);
+}
+
+static void rela32_write_addend(Elf_Rela *rela, uint64_t val)
+{
+	w(val, (uint32_t *)&rela->e32.r_addend);
+}
+
+static void rela_write_addend(Elf_Rela *rela, uint64_t val)
+{
+	e.rela_write_addend(rela, val);
+}
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
@@ -341,6 +387,16 @@ static void wle(uint32_t val, uint32_t *x)
 	put_unaligned_le32(val, x);
 }
 
+static void w8be(uint64_t val, uint64_t *x)
+{
+	put_unaligned_be64(val, x);
+}
+
+static void w8le(uint64_t val, uint64_t *x)
+{
+	put_unaligned_le64(val, x);
+}
+
 /*
  * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
  * the way to -256..-1, to avoid conflicting with real section
@@ -398,13 +454,12 @@ static inline void *get_index(void *start, int entsize, int index)
 static int extable_ent_size;
 static int long_size;
 
+#define ERRSTR_MAXSZ	256
 
 #ifdef UNWINDER_ORC_ENABLED
 /* ORC unwinder only support X86_64 */
 #include <asm/orc_types.h>
 
-#define ERRSTR_MAXSZ	256
-
 static char g_err[ERRSTR_MAXSZ];
 static int *g_orc_ip_table;
 static struct orc_entry *g_orc_table;
@@ -500,6 +555,11 @@ static void *sort_orctable(void *arg)
 
 #ifdef MCOUNT_SORT_ENABLED
 static pthread_t mcount_sort_thread;
+static bool sort_reloc;
+
+static long rela_type;
+
+static char m_err[ERRSTR_MAXSZ];
 
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
@@ -508,6 +568,103 @@ struct elf_mcount_loc {
 	uint64_t stop_mcount_loc;
 };
 
+/* Sort the relocations not the address itself */
+static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
+{
+	Elf_Shdr *shdr_start;
+	Elf_Rela *rel;
+	unsigned int shnum;
+	unsigned int count;
+	int shentsize;
+	void *vals;
+	void *ptr;
+
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
+
+	vals = malloc(long_size * size);
+	if (!vals) {
+		snprintf(m_err, ERRSTR_MAXSZ, "Failed to allocate sort array");
+		pthread_exit(m_err);
+		return NULL;
+	}
+
+	ptr = vals;
+
+	shnum = ehdr_shnum(ehdr);
+	if (shnum == SHN_UNDEF)
+		shnum = shdr_size(shdr_start);
+
+	for (int i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
+		void *end;
+
+		if (shdr_type(shdr) != SHT_RELA)
+			continue;
+
+		rel = (void *)ehdr + shdr_offset(shdr);
+		end = (void *)rel + shdr_size(shdr);
+
+		for (; (void *)rel < end; rel = (void *)rel + shdr_entsize(shdr)) {
+			uint64_t offset = rela_offset(rel);
+
+			if (offset >= start_loc && offset < start_loc + size) {
+				if (ptr + long_size > vals + size) {
+					free(vals);
+					snprintf(m_err, ERRSTR_MAXSZ,
+						 "Too many relocations");
+					pthread_exit(m_err);
+					return NULL;
+				}
+
+				/* Make sure this has the correct type */
+				if (rela_info(rel) != rela_type) {
+					free(vals);
+					snprintf(m_err, ERRSTR_MAXSZ,
+						"rela has type %lx but expected %lx\n",
+						(long)rela_info(rel), rela_type);
+					pthread_exit(m_err);
+					return NULL;
+				}
+
+				if (long_size == 4)
+					*(uint32_t *)ptr = rela_addend(rel);
+				else
+					*(uint64_t *)ptr = rela_addend(rel);
+				ptr += long_size;
+			}
+		}
+	}
+	count = ptr - vals;
+	qsort(vals, count / long_size, long_size, compare_extable);
+
+	ptr = vals;
+	for (int i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
+		void *end;
+
+		if (shdr_type(shdr) != SHT_RELA)
+			continue;
+
+		rel = (void *)ehdr + shdr_offset(shdr);
+		end = (void *)rel + shdr_size(shdr);
+
+		for (; (void *)rel < end; rel = (void *)rel + shdr_entsize(shdr)) {
+			uint64_t offset = rela_offset(rel);
+
+			if (offset >= start_loc && offset < start_loc + size) {
+				if (long_size == 4)
+					rela_write_addend(rel, *(uint32_t *)ptr);
+				else
+					rela_write_addend(rel, *(uint64_t *)ptr);
+				ptr += long_size;
+			}
+		}
+	}
+	free(vals);
+	return NULL;
+}
+
 /* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
 static void *sort_mcount_loc(void *arg)
 {
@@ -517,6 +674,9 @@ static void *sort_mcount_loc(void *arg)
 	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
+	if (sort_reloc)
+		return sort_relocs(emloc->ehdr, emloc->start_mcount_loc, count);
+
 	qsort(start_loc, count/long_size, long_size, compare_extable);
 	return NULL;
 }
@@ -866,12 +1026,14 @@ static int do_file(char const *const fname, void *addr)
 		r2	= r2le;
 		r8	= r8le;
 		w	= wle;
+		w8	= w8le;
 		break;
 	case ELFDATA2MSB:
 		r	= rbe;
 		r2	= r2be;
 		r8	= r8be;
 		w	= wbe;
+		w8	= w8be;
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
@@ -887,8 +1049,13 @@ static int do_file(char const *const fname, void *addr)
 	}
 
 	switch (r2(&ehdr->e32.e_machine)) {
-	case EM_386:
 	case EM_AARCH64:
+#ifdef MCOUNT_SORT_ENABLED
+		sort_reloc = true;
+		rela_type = 0x403;
+#endif
+		/* fallthrough */
+	case EM_386:
 	case EM_LOONGARCH:
 	case EM_RISCV:
 	case EM_S390:
@@ -932,6 +1099,10 @@ static int do_file(char const *const fname, void *addr)
 			.sym_name		= sym32_name,
 			.sym_value		= sym32_value,
 			.sym_shndx		= sym32_shndx,
+			.rela_offset		= rela32_offset,
+			.rela_info		= rela32_info,
+			.rela_addend		= rela32_addend,
+			.rela_write_addend	= rela32_write_addend,
 		};
 
 		e = efuncs;
@@ -965,6 +1136,10 @@ static int do_file(char const *const fname, void *addr)
 			.sym_name		= sym64_name,
 			.sym_value		= sym64_value,
 			.sym_shndx		= sym64_shndx,
+			.rela_offset		= rela64_offset,
+			.rela_info		= rela64_info,
+			.rela_addend		= rela64_addend,
+			.rela_write_addend	= rela64_write_addend,
 		};
 
 		e = efuncs;
-- 
2.45.2


