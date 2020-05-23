Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5F1DF692
	for <lists+linux-s390@lfdr.de>; Sat, 23 May 2020 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgEWKSh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 23 May 2020 06:18:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387721AbgEWKSe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 23 May 2020 06:18:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04N9WkKL133424;
        Sat, 23 May 2020 06:18:32 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3170b5hm1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 May 2020 06:18:32 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04NAFt1K003111;
        Sat, 23 May 2020 10:18:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 316uf886j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 May 2020 10:18:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04NAHECj64094512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 May 2020 10:17:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 692D15204E;
        Sat, 23 May 2020 10:18:27 +0000 (GMT)
Received: from localhost (unknown [9.145.5.233])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0C14452050;
        Sat, 23 May 2020 10:18:27 +0000 (GMT)
Date:   Sat, 23 May 2020 12:18:25 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.7-rc7
Message-ID: <your-ad-here.call-01590229105-ext-5688@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-23_05:2020-05-22,2020-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 cotscore=-2147483648 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=2 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005230079
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.7-rc7.

Thank you,
Vasily

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.7-4

for you to fetch changes up to 4c1cbcbd6c56c79de2c07159be4f55386bb0bef2:

  s390/kaslr: add support for R_390_JMP_SLOT relocation type (2020-05-20 10:13:27 +0200)

----------------------------------------------------------------
s390 updates for 5.7-rc7

- Add missing R_390_JMP_SLOT relocation type in KASLR code.

- Fix set_huge_pte_at for empty ptes issue which has been uncovered with
  arch page table helper tests.

- Correct initrd location for kdump kernel.

- Fix s390_mmio_read/write with MIO in PCI code.

----------------------------------------------------------------
Gerald Schaefer (2):
      s390/mm: fix set_huge_pte_at() for empty ptes
      s390/kaslr: add support for R_390_JMP_SLOT relocation type

Niklas Schnelle (1):
      s390/pci: Fix s390_mmio_read/write with MIO

Philipp Rudo (1):
      s390/kexec_file: fix initrd location for kdump kernel

 arch/s390/include/asm/pci_io.h         |  10 +-
 arch/s390/kernel/machine_kexec_file.c  |   2 +-
 arch/s390/kernel/machine_kexec_reloc.c |   1 +
 arch/s390/mm/hugetlbpage.c             |   9 +-
 arch/s390/pci/pci_mmio.c               | 213 ++++++++++++++++++++++++++++++++-
 5 files changed, 227 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/pci_io.h b/arch/s390/include/asm/pci_io.h
index cd060b5dd8fd..e4dc64cc9c55 100644
--- a/arch/s390/include/asm/pci_io.h
+++ b/arch/s390/include/asm/pci_io.h
@@ -8,6 +8,10 @@
 #include <linux/slab.h>
 #include <asm/pci_insn.h>
 
+/* I/O size constraints */
+#define ZPCI_MAX_READ_SIZE	8
+#define ZPCI_MAX_WRITE_SIZE	128
+
 /* I/O Map */
 #define ZPCI_IOMAP_SHIFT		48
 #define ZPCI_IOMAP_ADDR_BASE		0x8000000000000000UL
@@ -140,7 +144,8 @@ static inline int zpci_memcpy_fromio(void *dst,
 
 	while (n > 0) {
 		size = zpci_get_max_write_size((u64 __force) src,
-					       (u64) dst, n, 8);
+					       (u64) dst, n,
+					       ZPCI_MAX_READ_SIZE);
 		rc = zpci_read_single(dst, src, size);
 		if (rc)
 			break;
@@ -161,7 +166,8 @@ static inline int zpci_memcpy_toio(volatile void __iomem *dst,
 
 	while (n > 0) {
 		size = zpci_get_max_write_size((u64 __force) dst,
-					       (u64) src, n, 128);
+					       (u64) src, n,
+					       ZPCI_MAX_WRITE_SIZE);
 		if (size > 8) /* main path */
 			rc = zpci_write_block(dst, src, size);
 		else
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8415ae7d2a23..f9e4baa64b67 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -151,7 +151,7 @@ static int kexec_file_add_initrd(struct kimage *image,
 		buf.mem += crashk_res.start;
 	buf.memsz = buf.bufsz;
 
-	data->parm->initrd_start = buf.mem;
+	data->parm->initrd_start = data->memsz;
 	data->parm->initrd_size = buf.memsz;
 	data->memsz += buf.memsz;
 
diff --git a/arch/s390/kernel/machine_kexec_reloc.c b/arch/s390/kernel/machine_kexec_reloc.c
index d5035de9020e..b7182cec48dc 100644
--- a/arch/s390/kernel/machine_kexec_reloc.c
+++ b/arch/s390/kernel/machine_kexec_reloc.c
@@ -28,6 +28,7 @@ int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
 		break;
 	case R_390_64:		/* Direct 64 bit.  */
 	case R_390_GLOB_DAT:
+	case R_390_JMP_SLOT:
 		*(u64 *)loc = val;
 		break;
 	case R_390_PC16:	/* PC relative 16 bit.	*/
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index f01daddcbc5e..4632d4e26b66 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -159,10 +159,13 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		rste &= ~_SEGMENT_ENTRY_NOEXEC;
 
 	/* Set correct table type for 2G hugepages */
-	if ((pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3)
-		rste |= _REGION_ENTRY_TYPE_R3 | _REGION3_ENTRY_LARGE;
-	else
+	if ((pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3) {
+		if (likely(pte_present(pte)))
+			rste |= _REGION3_ENTRY_LARGE;
+		rste |= _REGION_ENTRY_TYPE_R3;
+	} else if (likely(pte_present(pte)))
 		rste |= _SEGMENT_ENTRY_LARGE;
+
 	clear_huge_pte_skeys(mm, rste);
 	pte_val(*ptep) = rste;
 }
diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 7d42a8794f10..020a2c514d96 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -11,6 +11,113 @@
 #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
+#include <asm/pci_io.h>
+#include <asm/pci_debug.h>
+
+static inline void zpci_err_mmio(u8 cc, u8 status, u64 offset)
+{
+	struct {
+		u64 offset;
+		u8 cc;
+		u8 status;
+	} data = {offset, cc, status};
+
+	zpci_err_hex(&data, sizeof(data));
+}
+
+static inline int __pcistb_mio_inuser(
+		void __iomem *ioaddr, const void __user *src,
+		u64 len, u8 *status)
+{
+	int cc = -ENXIO;
+
+	asm volatile (
+		"       sacf 256\n"
+		"0:     .insn   rsy,0xeb00000000d4,%[len],%[ioaddr],%[src]\n"
+		"1:     ipm     %[cc]\n"
+		"       srl     %[cc],28\n"
+		"2:     sacf 768\n"
+		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
+		: [cc] "+d" (cc), [len] "+d" (len)
+		: [ioaddr] "a" (ioaddr), [src] "Q" (*((u8 __force *)src))
+		: "cc", "memory");
+	*status = len >> 24 & 0xff;
+	return cc;
+}
+
+static inline int __pcistg_mio_inuser(
+		void __iomem *ioaddr, const void __user *src,
+		u64 ulen, u8 *status)
+{
+	register u64 addr asm("2") = (u64 __force) ioaddr;
+	register u64 len asm("3") = ulen;
+	int cc = -ENXIO;
+	u64 val = 0;
+	u64 cnt = ulen;
+	u8 tmp;
+
+	/*
+	 * copy 0 < @len <= 8 bytes from @src into the right most bytes of
+	 * a register, then store it to PCI at @ioaddr while in secondary
+	 * address space. pcistg then uses the user mappings.
+	 */
+	asm volatile (
+		"       sacf    256\n"
+		"0:     llgc    %[tmp],0(%[src])\n"
+		"       sllg    %[val],%[val],8\n"
+		"       aghi    %[src],1\n"
+		"       ogr     %[val],%[tmp]\n"
+		"       brctg   %[cnt],0b\n"
+		"1:     .insn   rre,0xb9d40000,%[val],%[ioaddr]\n"
+		"2:     ipm     %[cc]\n"
+		"       srl     %[cc],28\n"
+		"3:     sacf    768\n"
+		EX_TABLE(0b, 3b) EX_TABLE(1b, 3b) EX_TABLE(2b, 3b)
+		:
+		[src] "+a" (src), [cnt] "+d" (cnt),
+		[val] "+d" (val), [tmp] "=d" (tmp),
+		[len] "+d" (len), [cc] "+d" (cc),
+		[ioaddr] "+a" (addr)
+		:: "cc", "memory");
+	*status = len >> 24 & 0xff;
+
+	/* did we read everything from user memory? */
+	if (!cc && cnt != 0)
+		cc = -EFAULT;
+
+	return cc;
+}
+
+static inline int __memcpy_toio_inuser(void __iomem *dst,
+				   const void __user *src, size_t n)
+{
+	int size, rc = 0;
+	u8 status = 0;
+	mm_segment_t old_fs;
+
+	if (!src)
+		return -EINVAL;
+
+	old_fs = enable_sacf_uaccess();
+	while (n > 0) {
+		size = zpci_get_max_write_size((u64 __force) dst,
+					       (u64 __force) src, n,
+					       ZPCI_MAX_WRITE_SIZE);
+		if (size > 8) /* main path */
+			rc = __pcistb_mio_inuser(dst, src, size, &status);
+		else
+			rc = __pcistg_mio_inuser(dst, src, size, &status);
+		if (rc)
+			break;
+		src += size;
+		dst += size;
+		n -= size;
+	}
+	disable_sacf_uaccess(old_fs);
+	if (rc)
+		zpci_err_mmio(rc, status, (__force u64) dst);
+	return rc;
+}
 
 static long get_pfn(unsigned long user_addr, unsigned long access,
 		    unsigned long *pfn)
@@ -46,6 +153,20 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 
 	if (length <= 0 || PAGE_SIZE - (mmio_addr & ~PAGE_MASK) < length)
 		return -EINVAL;
+
+	/*
+	 * Only support read access to MIO capable devices on a MIO enabled
+	 * system. Otherwise we would have to check for every address if it is
+	 * a special ZPCI_ADDR and we would have to do a get_pfn() which we
+	 * don't need for MIO capable devices.
+	 */
+	if (static_branch_likely(&have_mio)) {
+		ret = __memcpy_toio_inuser((void  __iomem *) mmio_addr,
+					user_buffer,
+					length);
+		return ret;
+	}
+
 	if (length > 64) {
 		buf = kmalloc(length, GFP_KERNEL);
 		if (!buf)
@@ -56,7 +177,8 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 	ret = get_pfn(mmio_addr, VM_WRITE, &pfn);
 	if (ret)
 		goto out;
-	io_addr = (void __iomem *)((pfn << PAGE_SHIFT) | (mmio_addr & ~PAGE_MASK));
+	io_addr = (void __iomem *)((pfn << PAGE_SHIFT) |
+			(mmio_addr & ~PAGE_MASK));
 
 	ret = -EFAULT;
 	if ((unsigned long) io_addr < ZPCI_IOMAP_ADDR_BASE)
@@ -72,6 +194,78 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 	return ret;
 }
 
+static inline int __pcilg_mio_inuser(
+		void __user *dst, const void __iomem *ioaddr,
+		u64 ulen, u8 *status)
+{
+	register u64 addr asm("2") = (u64 __force) ioaddr;
+	register u64 len asm("3") = ulen;
+	u64 cnt = ulen;
+	int shift = ulen * 8;
+	int cc = -ENXIO;
+	u64 val, tmp;
+
+	/*
+	 * read 0 < @len <= 8 bytes from the PCI memory mapped at @ioaddr (in
+	 * user space) into a register using pcilg then store these bytes at
+	 * user address @dst
+	 */
+	asm volatile (
+		"       sacf    256\n"
+		"0:     .insn   rre,0xb9d60000,%[val],%[ioaddr]\n"
+		"1:     ipm     %[cc]\n"
+		"       srl     %[cc],28\n"
+		"       ltr     %[cc],%[cc]\n"
+		"       jne     4f\n"
+		"2:     ahi     %[shift],-8\n"
+		"       srlg    %[tmp],%[val],0(%[shift])\n"
+		"3:     stc     %[tmp],0(%[dst])\n"
+		"       aghi    %[dst],1\n"
+		"       brctg   %[cnt],2b\n"
+		"4:     sacf    768\n"
+		EX_TABLE(0b, 4b) EX_TABLE(1b, 4b) EX_TABLE(3b, 4b)
+		:
+		[cc] "+d" (cc), [val] "=d" (val), [len] "+d" (len),
+		[dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
+		[shift] "+d" (shift)
+		:
+		[ioaddr] "a" (addr)
+		: "cc", "memory");
+
+	/* did we write everything to the user space buffer? */
+	if (!cc && cnt != 0)
+		cc = -EFAULT;
+
+	*status = len >> 24 & 0xff;
+	return cc;
+}
+
+static inline int __memcpy_fromio_inuser(void __user *dst,
+				     const void __iomem *src,
+				     unsigned long n)
+{
+	int size, rc = 0;
+	u8 status;
+	mm_segment_t old_fs;
+
+	old_fs = enable_sacf_uaccess();
+	while (n > 0) {
+		size = zpci_get_max_write_size((u64 __force) src,
+					       (u64 __force) dst, n,
+					       ZPCI_MAX_READ_SIZE);
+		rc = __pcilg_mio_inuser(dst, src, size, &status);
+		if (rc)
+			break;
+		src += size;
+		dst += size;
+		n -= size;
+	}
+	disable_sacf_uaccess(old_fs);
+	if (rc)
+		zpci_err_mmio(rc, status, (__force u64) dst);
+	return rc;
+}
+
 SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 		void __user *, user_buffer, size_t, length)
 {
@@ -86,12 +280,27 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 
 	if (length <= 0 || PAGE_SIZE - (mmio_addr & ~PAGE_MASK) < length)
 		return -EINVAL;
+
+	/*
+	 * Only support write access to MIO capable devices on a MIO enabled
+	 * system. Otherwise we would have to check for every address if it is
+	 * a special ZPCI_ADDR and we would have to do a get_pfn() which we
+	 * don't need for MIO capable devices.
+	 */
+	if (static_branch_likely(&have_mio)) {
+		ret = __memcpy_fromio_inuser(
+				user_buffer, (const void __iomem *)mmio_addr,
+				length);
+		return ret;
+	}
+
 	if (length > 64) {
 		buf = kmalloc(length, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
-	} else
+	} else {
 		buf = local_buf;
+	}
 
 	ret = get_pfn(mmio_addr, VM_READ, &pfn);
 	if (ret)
