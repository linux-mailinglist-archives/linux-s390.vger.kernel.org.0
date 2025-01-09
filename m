Return-Path: <linux-s390+bounces-8135-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F86FA07F30
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jan 2025 18:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E088B1884AC8
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jan 2025 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33181199948;
	Thu,  9 Jan 2025 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL5SfNNB"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4A72B9BF
	for <linux-s390@vger.kernel.org>; Thu,  9 Jan 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444752; cv=none; b=YoPsZNj49XTsEgekP/oyQW/ofX4FGqbVOrtzE4Z/ipdczZj3StVEQkeWCVuB2uEDIde1cZcbtFec2oCp/ucsKxxnKQ8k6N+U6jFK4MDpc+ZPzlc2+CdQKyrWU6S2Puoe0CQwyB43MAWOdzB0Z0tf2CwOnOn/+FH9Ca4Va77GGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444752; c=relaxed/simple;
	bh=2O5jydmuf0klFJQtScyDPWkBNOYlD+ByU8JDOFky7QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kr3Zw9yacOevS4hFZTYyBUq+VIUXJ+TsiQUstjQvn9EQSJm+fJPgxiDW/GlZr/ji2xePRN8riXIm2bvo8B8o+A4RnSoFApZayY2dbBbHFqtuAgPrfe3xLQmNkONWs2NJw8mPWlECqEwBe/05OgzH/a/qaU003FRbTtbHYfsTNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL5SfNNB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736444748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hoYGkkFh/k/CpmxVYHzrGNTXoQJcfW//siB/lJA0dnE=;
	b=FL5SfNNBr+Fwnjk5e4F8BLMK/4ggX5L/h0nx+IRQUODvPv0eg27Y37xP6hIRK+Zdw3h5Ip
	gXEqsduqOHQra2WsfQ4MC98AiprMXFRfqdtXbYDbhWVwGmkb0AFHFfJPS6iiFE9vrc7L4E
	0bv7BzoikAzHud4etcPPoGuplQQAEBk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-_WD-si47OQSrDRe1hxlTxg-1; Thu, 09 Jan 2025 12:45:45 -0500
X-MC-Unique: _WD-si47OQSrDRe1hxlTxg-1
X-Mimecast-MFC-AGG-ID: _WD-si47OQSrDRe1hxlTxg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so595776f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2025 09:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736444745; x=1737049545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoYGkkFh/k/CpmxVYHzrGNTXoQJcfW//siB/lJA0dnE=;
        b=BqSZjaBwctU/LXdP1Q2CFxOxbR5uM/blE8OVZIbsGCo9bpXmfSm3nlPeFIamSFqrS8
         uzZIMk/V62E0RA154K5/5ErTbAfpJrom/xKPAnbMrbl41lfRbo6KhGE9AU0klfdCiLWB
         /t3knOKeOAji0PNd+vyBbjkvlySYqOC8xvlHlzIeetw1fN1nYOlMHHlWVheCdRHBerbN
         HXwPOeG74jjenmnkgo0T++XVVe1IJ2s7ADHP0/shaG5GGe7frfD5vpfKSKRTgeqye8TX
         DG00iy6EF6YR+LX1iHzPY6cHBOCi/iHbyqWj6opAahw6AAarOLSwBvnJLFQXqEIfTpz/
         UdYg==
X-Forwarded-Encrypted: i=1; AJvYcCWVYyuXTVpJUL3ouQ/PpRFrIgJos9HNb1t8QCFbxbU852qnXqC3acpGktV6L7Xxd+BCOT5BofjplovC@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6fkYAKkwsOvPKSbj+H/1ZtGFAaPDXEZPZZrAhHv+Lxgt3j3J
	pakLu1E1Ru8GzR+G/JxJUU0oQFhRejDc/rKMIIGQtO1pgicdUWqMiiGNWQdb/8YfMUsZY15QSx8
	ypAc2gMKZMknER/hdg854fU7jntnA6nlyVvHaUcBKXQ34nUz0xvDc5eO3Rg==
X-Gm-Gg: ASbGncveDjIQ2X+oseSpSIzmjZ2YUybJR+z/DrPketZnhRtdfPXPW1HFD3++ylXAwUw
	PF/HoZp7eXV0xHQynZdpAsgYvshEuuhI6/7KQXtMXgdBv/ImDQ4o/J0JovnUGwyW9sPwPBQ/zrp
	lr3PXNU52wDaGiHUvTNxtSXRJEqZhsr9edwmML85boaKKYnyFbsaP6SS7pxk0eH1trovHdhbmY8
	/kl+zSepIY6S+HzCThFMQlAYV1fcWVzDxrFVr0xg3DA1kE8tRYy8Q99mSRSgIt33iEfy227nuEM
	ZDHdC/dcj3LBRqc=
X-Received: by 2002:adf:a2c4:0:b0:386:2a3b:8aa with SMTP id ffacd0b85a97d-38a8733a3c9mr5464286f8f.37.1736444744614;
        Thu, 09 Jan 2025 09:45:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYn0dV7FSAAgSs+K9CwmOcADtTAtqrsBUMyckTD1hTf5pvDI6r/gTBa7WiYQz6cQqzZ2WLxQ==
X-Received: by 2002:adf:a2c4:0:b0:386:2a3b:8aa with SMTP id ffacd0b85a97d-38a8733a3c9mr5464241f8f.37.1736444744147;
        Thu, 09 Jan 2025 09:45:44 -0800 (PST)
Received: from thinky.redhat.com (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc14ebsm61288865e9.17.2025.01.09.09.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:45:43 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	linux-api@vger.kernel.org,
	monstr@monstr.eu,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	maddy@linux.ibm.com,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	arnd@arndb.de,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Date: Thu,  9 Jan 2025 18:45:40 +0100
Message-ID: <20250109174540.893098-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrey Albershteyn <aalbersh@redhat.com>

Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
extended attributes/flags. The syscalls take parent directory FD and
path to the child together with struct fsxattr.

This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
that file don't need to be open. By having this we can manipulated
inode extended attributes not only on normal files but also on
special ones. This is not possible with FS_IOC_FSSETXATTR ioctl as
opening special files returns VFS special inode instead of
underlying filesystem one.

This patch adds two new syscalls which allows userspace to set
extended inode attributes on special files by using parent directory
to open FS inode.

Also, as vfs_fileattr_set() is now will be called on special files
too, let's forbid any other attributes except projid and nextents
(symlink can have an extent).

CC: linux-api@vger.kernel.org
Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---

Notes:
    Previous discussion:
    https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/
    
    XFS has project quotas which could be attached to a directory. All
    new inodes in these directories inherit project ID set on parent
    directory.
    
    The project is created from userspace by opening and calling
    FS_IOC_FSSETXATTR on each inode. This is not possible for special
    files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
    with empty project ID. Those inodes then are not shown in the quota
    accounting but still exist in the directory. Moreover, in the case
    when special files are created in the directory with already
    existing project quota, these inode inherit extended attributes.
    This than leaves them with these attributes without the possibility
    to clear them out. This, in turn, prevents userspace from
    re-creating quota project on these existing files.

 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 fs/inode.c                                  | 105 ++++++++++++++++++++
 fs/ioctl.c                                  |  17 +++-
 include/linux/fileattr.h                    |   1 +
 include/linux/syscalls.h                    |   4 +
 include/uapi/asm-generic/unistd.h           |   8 +-
 16 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index c59d53d6d3f3..4b9e687494c1 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -506,3 +506,5 @@
 574	common	getxattrat			sys_getxattrat
 575	common	listxattrat			sys_listxattrat
 576	common	removexattrat			sys_removexattrat
+577	common	getfsxattrat			sys_getfsxattrat
+578	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f5ed71f1910d..159476387f39 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -466,3 +466,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 680f568b77f2..a6d59ee740b5 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -472,3 +472,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index d9fc94c86965..b3578fac43d6 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -465,3 +465,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index d8b4ab78bef0..808045d82c94 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -557,3 +557,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e9115b4d8b63..78dfc2c184d4 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -469,3 +469,5 @@
 464  common	getxattrat		sys_getxattrat			sys_getxattrat
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
+467  common	getfsxattrat		sys_getfsxattrat		sys_getfsxattrat
+468  common	setfsxattrat		sys_setfsxattrat		sys_setfsxattrat
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c8cad33bf250..d5a5c8339f0e 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 727f99d333b3..817dcd8603bc 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -512,3 +512,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4d0fb2fba7e2..b4842c027c5d 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -472,3 +472,5 @@
 464	i386	getxattrat		sys_getxattrat
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
+467	i386	getfsxattrat		sys_getfsxattrat
+468	i386	setfsxattrat		sys_setfsxattrat
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5eb708bff1c7..b6f0a7236aae 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -390,6 +390,8 @@
 464	common	getxattrat		sys_getxattrat
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
+467	common	getfsxattrat		sys_getfsxattrat
+468	common	setfsxattrat		sys_setfsxattrat
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 37effc1b134e..425d56be337d 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -437,3 +437,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/fs/inode.c b/fs/inode.c
index 6b4c77268fc0..fc8939c6c8a7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -23,6 +23,9 @@
 #include <linux/rw_hint.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/syscalls.h>
+#include <linux/fileattr.h>
+#include <linux/namei.h>
 #include <trace/events/writeback.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/timestamp.h>
@@ -2953,3 +2956,105 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 	return mode & ~S_ISGID;
 }
 EXPORT_SYMBOL(mode_strip_sgid);
+
+SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
+		struct fsxattr *, fsx, int, at_flags)
+{
+	struct fd dir;
+	struct fileattr fa;
+	struct path filepath;
+	struct inode *inode;
+	int error;
+
+	if (at_flags)
+		return -EINVAL;
+
+	if (!capable(CAP_FOWNER))
+		return -EPERM;
+
+	dir = fdget(dfd);
+	if (!fd_file(dir))
+		return -EBADF;
+
+	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
+		error = -EBADF;
+		goto out;
+	}
+
+	error = user_path_at(dfd, filename, at_flags, &filepath);
+	if (error)
+		goto out;
+
+	inode = filepath.dentry->d_inode;
+	if (file_inode(fd_file(dir))->i_sb->s_magic != inode->i_sb->s_magic) {
+		error = -EBADF;
+		goto out_path;
+	}
+
+	error = vfs_fileattr_get(filepath.dentry, &fa);
+	if (error)
+		goto out_path;
+
+	if (copy_fsxattr_to_user(&fa, fsx))
+		error = -EFAULT;
+
+out_path:
+	path_put(&filepath);
+out:
+	fdput(dir);
+	return error;
+}
+
+SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
+		struct fsxattr *, fsx, int, at_flags)
+{
+	struct fd dir;
+	struct fileattr fa;
+	struct inode *inode;
+	struct path filepath;
+	int error;
+
+	if (at_flags)
+		return -EINVAL;
+
+	if (!capable(CAP_FOWNER))
+		return -EPERM;
+
+	dir = fdget(dfd);
+	if (!fd_file(dir))
+		return -EBADF;
+
+	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
+		error = -EBADF;
+		goto out;
+	}
+
+	if (copy_fsxattr_from_user(&fa, fsx)) {
+		error = -EFAULT;
+		goto out;
+	}
+
+	error = user_path_at(dfd, filename, at_flags, &filepath);
+	if (error)
+		goto out;
+
+	inode = filepath.dentry->d_inode;
+	if (file_inode(fd_file(dir))->i_sb->s_magic != inode->i_sb->s_magic) {
+		error = -EBADF;
+		goto out_path;
+	}
+
+	error = mnt_want_write(filepath.mnt);
+	if (error)
+		goto out_path;
+
+	error = vfs_fileattr_set(file_mnt_idmap(fd_file(dir)), filepath.dentry,
+				 &fa);
+	mnt_drop_write(filepath.mnt);
+
+out_path:
+	path_put(&filepath);
+out:
+	fdput(dir);
+	return error;
+}
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 638a36be31c1..df14f1868165 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -558,8 +558,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 }
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
-static int copy_fsxattr_from_user(struct fileattr *fa,
-				  struct fsxattr __user *ufa)
+int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
 
@@ -574,6 +573,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 
 	return 0;
 }
+EXPORT_SYMBOL(copy_fsxattr_from_user);
 
 /*
  * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
@@ -646,6 +646,19 @@ static int fileattr_set_prepare(struct inode *inode,
 	if (fa->fsx_cowextsize == 0)
 		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
 
+	/*
+	 * The only use case for special files is to set project ID, forbid any
+	 * other attributes
+	 */
+	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
+		if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+		if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
+			return -EINVAL;
+		if (fa->fsx_extsize || fa->fsx_cowextsize)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 47c05a9851d0..8598e94b530b 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -34,6 +34,7 @@ struct fileattr {
 };
 
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
+int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa);
 
 void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
 void fileattr_fill_flags(struct fileattr *fa, u32 flags);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c6333204d451..a983023d21ab 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -371,6 +371,10 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
 asmlinkage long sys_lremovexattr(const char __user *path,
 				 const char __user *name);
 asmlinkage long sys_fremovexattr(int fd, const char __user *name);
+asmlinkage long sys_getfsxattrat(int dfd, const char __user *filename,
+				 struct fsxattr *fsx, int at_flags);
+asmlinkage long sys_setfsxattrat(int dfd, const char __user *filename,
+				 struct fsxattr *fsx, int at_flags);
 asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
 asmlinkage long sys_eventfd2(unsigned int count, int flags);
 asmlinkage long sys_epoll_create1(int flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 88dc393c2bca..50be2e1007bc 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -850,8 +850,14 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
 #define __NR_removexattrat 466
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
 
+/* fs/inode.c */
+#define __NR_getfsxattrat 467
+__SYSCALL(__NR_getfsxattrat, sys_getfsxattrat)
+#define __NR_setfsxattrat 468
+__SYSCALL(__NR_setfsxattrat, sys_setfsxattrat)
+
 #undef __NR_syscalls
-#define __NR_syscalls 467
+#define __NR_syscalls 469
 
 /*
  * 32 bit systems traditionally used different
-- 
2.47.0


