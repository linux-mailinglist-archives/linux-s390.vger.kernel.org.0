Return-Path: <linux-s390+bounces-5227-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D59A942D46
	for <lists+linux-s390@lfdr.de>; Wed, 31 Jul 2024 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BAA1C214E3
	for <lists+linux-s390@lfdr.de>; Wed, 31 Jul 2024 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC3634CDE;
	Wed, 31 Jul 2024 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SVKLP+Kh"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306381A71EB
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425472; cv=none; b=unsB5dD5xHEBO7Q1w9UJaxy8fvXE4WfCgR7IMqcqjAVCicpAODUd8ckZPjAOenj1mOjcK7ZEB/oMRsZhyDg8pUulh3MpW/RNIAwAsRlYoAnvTFHi1Nu2iNREmDibFIMPHwHwNHtPsk2WMc3EEd1dl8G8JoaJa/KB90fadeFNNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425472; c=relaxed/simple;
	bh=B5LjsGmjUnGgC+3S3K4vgufSp6MgbbSVrQQVJKjPAqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlcZpceJmMJKntwnLoVaAWxtQcrk070O5hYMfUAvSYTDcitSIhh91VjcTkmO7P40C1mV6SBb945u0ai+1UlKeSrmvZx9Z8Ok7UBKtAtxCkz8tiR2zeDxOCETkPfR0lrrLVXACeoMB4V+DXoFryiMrUcqMYESL1xFKi4KjH8NrBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SVKLP+Kh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V9xKI3018662
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 11:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=45CkuGD/86iKKCzErMLWJiA5f4Ert2ueHMCgSAN
	L0nQ=; b=SVKLP+Khy6HsiqD5OTF6j+ndg2Sy0ddMC6Q2mFh9fc97VCcPzFSFDta
	dKndnr7NRQl+r6LBnisWNpgln7j/kU+W0IeDTAVknP6wqlYi8NiOUz7SJ11loXvH
	8swQ29ZtdYO4kPvttnZt0EcXERjO+mDIwotbvDixgmLGT3x+enpEbhDRryvoNNXL
	4i2g/Ws9KybcB6zDa6C026pdVTzjy2zCZQ3HOs6BYXTfcXzEw2JNH8YT/E7dhiWH
	Z54GpcW2QStV2ISzH9F1LoGkJHC39Vc6VJu+mhX3YMru91NuBWZDYtb0Q6aRKFnT
	i0nZnmknFc5HOFmTEdyY4d9BuPNgb5g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qk46r66h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 11:31:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46VA9Xg9009218
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 11:31:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx32v9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 11:31:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46VBV25M22020578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 11:31:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E7072004D;
	Wed, 31 Jul 2024 11:31:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 492AC2005A;
	Wed, 31 Jul 2024 11:31:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 11:31:02 +0000 (GMT)
From: Michael Mueller <mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        mimu@linux.ibm.com
Subject: [PATCH] KVM: s390: fix validity interception issue when gisa is switched off
Date: Wed, 31 Jul 2024 13:31:02 +0200
Message-ID: <20240731113102.849562-1-mimu@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NeRw4psXYqIiJVylSiHeKo3PMHiBTeqW
X-Proofpoint-GUID: NeRw4psXYqIiJVylSiHeKo3PMHiBTeqW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407310084

The following validity interception occures when the gisa usage has been
switched off either by using kernel parameter "kvm.use_gisa=0" or by
setting the related sysfs attribute to N (echo N >/sys/module/kvm/
parameters/use_gisa).

The issue surfaces in the host kernel with the following kernel message as
soon a new kvm guest start has been attemted.

kvm: unhandled validity intercept 0x1011
WARNING: CPU: 0 PID: 781237 at arch/s390/kvm/intercept.c:101 kvm_handle_sie_intercept+0x42e/0x4d0 [kvm]
Modules linked in: vhost_net tap tun xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat x_tables nf_nat_tftp nf_conntrack_tftp vfio_pci_core irqbypass vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb kvm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables sunrpc mlx5_ib ib_uverbs ib_core mlx5_core uvdevice s390_trng eadm_sch vfio_ccw zcrypt_cex4 mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core loop drm_panel_orientation_quirks configfs nfnetlink lcs ctcm fsm dm_service_time ghash_s390 prng chacha_s390 libchacha aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common dm_mirror dm_region_hash dm_log zfcp scsi_transport_fc scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkey zcrypt dm_multipath rng_core autofs4 [last unloaded: vfio_pci]
CPU: 0 PID: 781237 Comm: CPU 0/KVM Not tainted 6.10.0-08682-gcad9f11498ea #6
Hardware name: IBM 3931 A01 701 (LPAR)
Krnl PSW : 0704c00180000000 000003d93deb0122 (kvm_handle_sie_intercept+0x432/0x4d0 [kvm])
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 000003d900000027 000003d900000023 0000000000000028 000002cd00000000
           000002d063a00900 00000359c6daf708 00000000000bebb5 0000000000001eff
           000002cfd82e9000 000002cfd80bc000 0000000000001011 000003d93deda412
           000003ff8962df98 000003d93de77ce0 000003d93deb011e 00000359c6daf960
Krnl Code: 000003d93deb0112: c020fffe7259	larl	%r2,000003d93de7e5c4
           000003d93deb0118: c0e53fa8beac	brasl	%r14,000003d9bd3c7e70
          #000003d93deb011e: af000000		mc	0,0
          >000003d93deb0122: a728ffea		lhi	%r2,-22
           000003d93deb0126: a7f4fe24		brc	15,000003d93deafd6e
           000003d93deb012a: 9101f0b0		tm	176(%r15),1
           000003d93deb012e: a774fe48		brc	7,000003d93deafdbe
           000003d93deb0132: 40a0f0ae		sth	%r10,174(%r15)
Call Trace:
 [<000003d93deb0122>] kvm_handle_sie_intercept+0x432/0x4d0 [kvm]
([<000003d93deb011e>] kvm_handle_sie_intercept+0x42e/0x4d0 [kvm])
 [<000003d93deacc10>] vcpu_post_run+0x1d0/0x3b0 [kvm]
 [<000003d93deaceda>] __vcpu_run+0xea/0x2d0 [kvm]
 [<000003d93dead9da>] kvm_arch_vcpu_ioctl_run+0x16a/0x430 [kvm]
 [<000003d93de93ee0>] kvm_vcpu_ioctl+0x190/0x7c0 [kvm]
 [<000003d9bd728b4e>] vfs_ioctl+0x2e/0x70
 [<000003d9bd72a092>] __s390x_sys_ioctl+0xc2/0xd0
 [<000003d9be0e9222>] __do_syscall+0x1f2/0x2e0
 [<000003d9be0f9a90>] system_call+0x70/0x98
Last Breaking-Event-Address:
 [<000003d9bd3c7f58>] __warn_printk+0xe8/0xf0

Cc: stable@vger.kernel.org
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Closes: https://ibm-systems-z.slack.com/archives/C04BWBXSKEY/p1722280755665409
Fixes: fe0ef0030463 ("KVM: s390: sort out physical vs virtual pointers usage")
Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index bf8534218af3..e680c6bf0c9d 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -267,7 +267,12 @@ static inline unsigned long kvm_s390_get_gfn_end(struct kvm_memslots *slots)
 
 static inline u32 kvm_s390_get_gisa_desc(struct kvm *kvm)
 {
-	u32 gd = virt_to_phys(kvm->arch.gisa_int.origin);
+	u32 gd;
+
+	if (!kvm->arch.gisa_int.origin)
+		return 0;
+
+	gd = virt_to_phys(kvm->arch.gisa_int.origin);
 
 	if (gd && sclp.has_gisaf)
 		gd |= GISA_FORMAT1;
-- 
2.43.0


