Return-Path: <linux-s390+bounces-7408-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C5E9E3A95
	for <lists+linux-s390@lfdr.de>; Wed,  4 Dec 2024 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AAF282494
	for <lists+linux-s390@lfdr.de>; Wed,  4 Dec 2024 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA6C204F92;
	Wed,  4 Dec 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Znxh+YCj"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC21FCF72
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316917; cv=none; b=F/12dZIK2EVs1RJEDcwxQQHTHI3pJ4QT4arQpxWWvNgABfx4Kbf7XD884syk9D+R/Orc/rFCu0xRBU9ivcOvbUe+joOc97PhOTmzo0pLH/ZjZiSRbvC9rR8tTnb8NmQpDN5VSmSHXl1yDX2FoOCSRd3Ve1fpgXr1lizuO8Otc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316917; c=relaxed/simple;
	bh=Rg9yOQYGTd6pgwnyhp2VaHUTS4HPDRcUrf1ti8sagOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8NdmKO8YbpgHkUK44PHeUkYRFIW4Tlacle+DB3MsHPRkmh6OcsDHDbOYCFGvwHDWvvja6DpDHY6ZkMq6pM6WKhHDEGGHHiJdhX8YXkyQ/BQ/DZ/JaP3qQrgYLn4GLqPOFnPj5qTWDAljBaSgaR5wQgQpYjfD6lSecq8o0A90XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Znxh+YCj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHduTfm8MEvatODJJecU9qsghwDNoQQYbaQi+lekCuQ=;
	b=Znxh+YCjOUAruVpE4AV8DbPpUbYnkRG/L63N77HWqJ4VPBwJckbES0hCDcV60VGJVuqlv1
	PTFkFDBsRsRPwLY12p7E8hV3moU68YBu65amrY/xK0AYSOQFBQ21JFYkIP+4QB5I25/0ZO
	Lt2fsa38Rq7crfjmCG1iW6XFocGInA0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-GkoR-sr3M6eDcRwPLQwAwQ-1; Wed, 04 Dec 2024 07:55:11 -0500
X-MC-Unique: GkoR-sr3M6eDcRwPLQwAwQ-1
X-Mimecast-MFC-AGG-ID: GkoR-sr3M6eDcRwPLQwAwQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43498af7937so55218565e9.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Dec 2024 04:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316910; x=1733921710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHduTfm8MEvatODJJecU9qsghwDNoQQYbaQi+lekCuQ=;
        b=mbmBNCwyEyZch3z/w0ucSzFqqWmjmvd6vgkz4wuJ7ltO3ZABOa0Wd9se6dBI4JH3TT
         h6MxMBoSa2swIG08JX/E01bsmOmV53edIGSNSETO3cAf4u8yyxm9A9Ookx9RfDtr//xS
         OgvjENyKUJnnP7Jdozy+2sGZUOLd4jh+kMQPewgR2a5b5fEhBqu2WKr/pButdj2Vj63W
         FIGApaTMeobzorl621RcpGwpwP5tK5LdLnvfy0uvqSwNXI99ZRUjkkJ0tZnPypIU30yh
         6P7nvpELnVvPHb2ygR8sxfMhIpbXH7JHQfNwzafKHs4TDwCxvETCDFFtyeYMUfWJNppl
         /3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP/yoz/v8n/E6UZaAENqegRG3/O/YCMne2PogO8pmcq6haJBJA8L32CZpquincf4goaT0EoQXa3gZN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6m1xmExPvHasOH25ytSOYQqJ9gbHPEJ1Ngc37/8WGf5eSZF4H
	sOkg+ajuVf0GQir3Z1QOO2Fuixf/eXERMj7zk3GW+PpUKkuuBTWTjiwhkQ0oluSs3gEB1RzB1YV
	1UnRFdCFRtHnivk+72qoijM53GjQStdFbA5Gn4FI5IFPXy6beTkapGuYa1sg=
X-Gm-Gg: ASbGncvIDdTBOZEYFcXi4bbyxYHejEeuyhi4m924O4AQE8Pk/8P2ZK66KhNR49zxxEi
	w0GreXB9See2ppP0EoW4C7DVHx7HhcNJpI9rEJopIVkK4jyqLsgVs6pCH9b2vD5s8e93cUmiZJ5
	uSQwtDbCuXX2jCp4mTxRzReHaQ1wnVZ7nrG7pMLu1G+LSpbwWOGCRiocALZRZaO73w/Nlt5mm84
	D1KkuDj2/JZDvp0mnW5N7T8f7bcTRX7DWhg3s3x/wDZ7ib/1BvGqqtqgIeFEkqaJtLqN6lVpItk
	Q8FelCgFiJZiyUxrS97RFW7ur5AhqVtssDo=
X-Received: by 2002:a05:600c:1c88:b0:434:9df4:5472 with SMTP id 5b1f17b1804b1-434d0a15068mr60073595e9.31.1733316910510;
        Wed, 04 Dec 2024 04:55:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWq3Nj3w3HYlBbZnRWgOzE8l6L8boPfRZN2lwS+xZGCeTjU6KZId+aHdXHdM4P1FN9VEFBqg==
X-Received: by 2002:a05:600c:1c88:b0:434:9df4:5472 with SMTP id 5b1f17b1804b1-434d0a15068mr60073175e9.31.1733316910084;
        Wed, 04 Dec 2024 04:55:10 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d5280746sm23704445e9.21.2024.12.04.04.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:09 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 08/12] fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM ranges in 2nd kernel
Date: Wed,  4 Dec 2024 13:54:39 +0100
Message-ID: <20241204125444.1734652-9-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s390 allocates+prepares the elfcore hdr in the dump (2nd) kernel, not in
the crashed kernel.

RAM provided by memory devices such as virtio-mem can only be detected
using the device driver; when vmcore_init() is called, these device
drivers are usually not loaded yet, or the devices did not get probed
yet. Consequently, on s390 these RAM ranges will not be included in
the crash dump, which makes the dump partially corrupt and is
unfortunate.

Instead of deferring the vmcore_init() call, to an (unclear?) later point,
let's reuse the vmcore_cb infrastructure to obtain device RAM ranges as
the device drivers probe the device and get access to this information.

Then, we'll add these ranges to the vmcore, adding more PT_LOAD
entries and updating the offsets+vmcore size.

Use a separate Kconfig option to be set by an architecture to include this
code only if the arch really needs it. Further, we'll make the config
depend on the relevant drivers (i.e., virtio_mem) once they implement
support (next). The alternative of having a PROVIDE_PROC_VMCORE_DEVICE_RAM
config option was dropped for now for simplicity.

The current target use case is s390, which only creates an elf64
elfcore, so focusing on elf64 is sufficient.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/Kconfig            |  18 +++++
 fs/proc/vmcore.c           | 156 +++++++++++++++++++++++++++++++++++++
 include/linux/crash_dump.h |   9 +++
 3 files changed, 183 insertions(+)

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index d80a1431ef7b..5668620ab34d 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -61,6 +61,24 @@ config PROC_VMCORE_DEVICE_DUMP
 	  as ELF notes to /proc/vmcore. You can still disable device
 	  dump using the kernel command line option 'novmcoredd'.
 
+config NEED_PROC_VMCORE_DEVICE_RAM
+	bool
+
+config PROC_VMCORE_DEVICE_RAM
+	def_bool y
+	depends on PROC_VMCORE && NEED_PROC_VMCORE_DEVICE_RAM
+	help
+	  If the elfcore hdr is allocated and prepared by the dump kernel
+	  ("2nd kernel") instead of the crashed kernel, RAM provided by memory
+	  devices such as virtio-mem will not be included in the dump
+	  image, because only the device driver can properly detect them.
+
+	  With this config enabled, these RAM ranges will be queried from the
+	  device drivers once the device gets probed, so they can be included
+	  in the crash dump.
+
+	  Relevant architectures should select NEED_PROC_VMCORE_DEVICE_RAM.
+
 config PROC_SYSCTL
 	bool "Sysctl support (/proc/sys)" if EXPERT
 	depends on PROC_FS
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index e7b3cde44890..6dc293d0eb5b 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -79,6 +79,8 @@ static bool vmcore_opened;
 /* Whether the vmcore is currently open. */
 static unsigned int vmcore_open;
 
+static void vmcore_process_device_ram(struct vmcore_cb *cb);
+
 void register_vmcore_cb(struct vmcore_cb *cb)
 {
 	INIT_LIST_HEAD(&cb->next);
@@ -90,6 +92,8 @@ void register_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback registration\n");
+	if (!vmcore_open && cb->get_device_ram)
+		vmcore_process_device_ram(cb);
 	mutex_unlock(&vmcore_mutex);
 }
 EXPORT_SYMBOL_GPL(register_vmcore_cb);
@@ -1535,6 +1539,158 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 EXPORT_SYMBOL(vmcore_add_device_dump);
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+static int vmcore_realloc_elfcore_buffer_elf64(size_t new_size)
+{
+	char *elfcorebuf_new;
+
+	if (WARN_ON_ONCE(new_size < elfcorebuf_sz))
+		return -EINVAL;
+	if (get_order(elfcorebuf_sz_orig) == get_order(new_size)) {
+		elfcorebuf_sz_orig = new_size;
+		return 0;
+	}
+
+	elfcorebuf_new = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						  get_order(new_size));
+	if (!elfcorebuf_new)
+		return -ENOMEM;
+	memcpy(elfcorebuf_new, elfcorebuf, elfcorebuf_sz);
+	free_pages((unsigned long)elfcorebuf, get_order(elfcorebuf_sz_orig));
+	elfcorebuf = elfcorebuf_new;
+	elfcorebuf_sz_orig = new_size;
+	return 0;
+}
+
+static void vmcore_reset_offsets_elf64(void)
+{
+	Elf64_Phdr *phdr_start = (Elf64_Phdr *)(elfcorebuf + sizeof(Elf64_Ehdr));
+	loff_t vmcore_off = elfcorebuf_sz + elfnotes_sz;
+	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)elfcorebuf;
+	Elf64_Phdr *phdr;
+	int i;
+
+	for (i = 0, phdr = phdr_start; i < ehdr->e_phnum; i++, phdr++) {
+		u64 start, end;
+
+		/*
+		 * After merge_note_headers_elf64() we should only have a single
+		 * PT_NOTE entry that starts immediately after elfcorebuf_sz.
+		 */
+		if (phdr->p_type == PT_NOTE) {
+			phdr->p_offset = elfcorebuf_sz;
+			continue;
+		}
+
+		start = rounddown(phdr->p_offset, PAGE_SIZE);
+		end = roundup(phdr->p_offset + phdr->p_memsz, PAGE_SIZE);
+		phdr->p_offset = vmcore_off + (phdr->p_offset - start);
+		vmcore_off = vmcore_off + end - start;
+	}
+	set_vmcore_list_offsets(elfcorebuf_sz, elfnotes_sz, &vmcore_list);
+}
+
+static int vmcore_add_device_ram_elf64(struct list_head *list, size_t count)
+{
+	Elf64_Phdr *phdr_start = (Elf64_Phdr *)(elfcorebuf + sizeof(Elf64_Ehdr));
+	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)elfcorebuf;
+	struct vmcore_range *cur;
+	Elf64_Phdr *phdr;
+	size_t new_size;
+	int rc;
+
+	if ((Elf32_Half)(ehdr->e_phnum + count) != ehdr->e_phnum + count) {
+		pr_err("too many device ram ranges\n");
+		return -ENOSPC;
+	}
+
+	/* elfcorebuf_sz must always cover full pages. */
+	new_size = sizeof(Elf64_Ehdr) +
+		   (ehdr->e_phnum + count) * sizeof(Elf64_Phdr);
+	new_size = roundup(new_size, PAGE_SIZE);
+
+	/*
+	 * Make sure we have sufficient space to include the new PT_LOAD
+	 * entries.
+	 */
+	rc = vmcore_realloc_elfcore_buffer_elf64(new_size);
+	if (rc) {
+		pr_err("resizing elfcore failed\n");
+		return rc;
+	}
+
+	/* Modify our used elfcore buffer size to cover the new entries. */
+	elfcorebuf_sz = new_size;
+
+	/* Fill the added PT_LOAD entries. */
+	phdr = phdr_start + ehdr->e_phnum;
+	list_for_each_entry(cur, list, list) {
+		WARN_ON_ONCE(!IS_ALIGNED(cur->paddr | cur->size, PAGE_SIZE));
+		elfcorehdr_fill_device_ram_ptload_elf64(phdr, cur->paddr, cur->size);
+
+		/* p_offset will be adjusted later. */
+		phdr++;
+		ehdr->e_phnum++;
+	}
+	list_splice_tail(list, &vmcore_list);
+
+	/* We changed elfcorebuf_sz and added new entries; reset all offsets. */
+	vmcore_reset_offsets_elf64();
+
+	/* Finally, recalculate the total vmcore size. */
+	vmcore_size = get_vmcore_size(elfcorebuf_sz, elfnotes_sz,
+				      &vmcore_list);
+	proc_vmcore->size = vmcore_size;
+	return 0;
+}
+
+static void vmcore_process_device_ram(struct vmcore_cb *cb)
+{
+	unsigned char *e_ident = (unsigned char *)elfcorebuf;
+	struct vmcore_range *first, *m;
+	LIST_HEAD(list);
+	int count;
+
+	/* We only support Elf64 dumps for now. */
+	if (WARN_ON_ONCE(e_ident[EI_CLASS] != ELFCLASS64)) {
+		pr_err("device ram ranges only support Elf64\n");
+		return;
+	}
+
+	if (cb->get_device_ram(cb, &list)) {
+		pr_err("obtaining device ram ranges failed\n");
+		return;
+	}
+	count = list_count_nodes(&list);
+	if (!count)
+		return;
+
+	/*
+	 * For some reason these ranges are already know? Might happen
+	 * with unusual register->unregister->register sequences; we'll simply
+	 * sanity check using the first range.
+	 */
+	first = list_first_entry(&list, struct vmcore_range, list);
+	list_for_each_entry(m, &vmcore_list, list) {
+		unsigned long long m_end = m->paddr + m->size;
+		unsigned long long first_end = first->paddr + first->size;
+
+		if (first->paddr < m_end && m->paddr < first_end)
+			goto out_free;
+	}
+
+	/* If adding the mem nodes succeeds, they must not be freed. */
+	if (!vmcore_add_device_ram_elf64(&list, count))
+		return;
+out_free:
+	vmcore_free_ranges(&list);
+}
+#else /* !CONFIG_PROC_VMCORE_DEVICE_RAM */
+static void vmcore_process_device_ram(struct vmcore_cb *cb)
+{
+}
+#endif /* CONFIG_PROC_VMCORE_DEVICE_RAM */
+
 /* Free all dumps in vmcore device dump list */
 static void vmcore_free_device_dumps(void)
 {
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 5d61c7454fd6..2f2555e6407c 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -20,6 +20,8 @@ extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
 extern ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos);
 extern ssize_t elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos);
+void elfcorehdr_fill_device_ram_ptload_elf64(Elf64_Phdr *phdr,
+		unsigned long long paddr, unsigned long long size);
 extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot);
@@ -99,6 +101,12 @@ static inline void vmcore_unusable(void)
  *              indicated in the vmcore instead. For example, a ballooned page
  *              contains no data and reading from such a page will cause high
  *              load in the hypervisor.
+ * @get_device_ram: query RAM ranges that can only be detected by device
+ *   drivers, such as the virtio-mem driver, so they can be included in
+ *   the crash dump on architectures that allocate the elfcore hdr in the dump
+ *   ("2nd") kernel. Indicated RAM ranges may contain holes to reduce the
+ *   total number of ranges; such holes can be detected using the pfn_is_ram
+ *   callback just like for other RAM.
  * @next: List head to manage registered callbacks internally; initialized by
  *        register_vmcore_cb().
  *
@@ -109,6 +117,7 @@ static inline void vmcore_unusable(void)
  */
 struct vmcore_cb {
 	bool (*pfn_is_ram)(struct vmcore_cb *cb, unsigned long pfn);
+	int (*get_device_ram)(struct vmcore_cb *cb, struct list_head *list);
 	struct list_head next;
 };
 extern void register_vmcore_cb(struct vmcore_cb *cb);
-- 
2.47.1


