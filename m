Return-Path: <linux-s390+bounces-20851-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 679lFIjzL2rfJgUAu9opvQ
	(envelope-from <linux-s390+bounces-20851-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 14:43:52 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A3F68657D
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 14:43:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=eOmTtxOR;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20851-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20851-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFC69300B456
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 12:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F53F4830;
	Mon, 15 Jun 2026 12:43:01 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EA3F411A;
	Mon, 15 Jun 2026 12:42:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527380; cv=none; b=lKLYe0uA8/GBK+ucHNRDiUXGAcB9Vu0rRN6ojMfaELOz9tce75qngLS0Pl1U9YTc3dcYKlRVHrUvbXQQKyXKSDhwYT5XE2TP/ERIxPPW0oyQIUm1BuL39eLYOk8xNiC6dwiZg5vKwUjALjdssOPSbATfyosn8XzGKP0njsZ8X8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527380; c=relaxed/simple;
	bh=K+KyZsjkaYKIk3DaXRlWdMnpNhOT7xOtnD+SAwJukDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch9V9G3sldbHTvV5ZE3Hn3b9tPTFNJ/v77rrYXYqPfLNJm5x/Y0uz8mDdCU3Hn3vgNozuxSCalta9OKwwaC6fWFTVC7SvEtwES33R5kcLwYPuXoquxGpz6suJ1RFA9utnrmsblf+CtYZhq0UYt3BfRQtDlCdrsay3PaYnMNL94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eOmTtxOR; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FApjmd2231509;
	Mon, 15 Jun 2026 12:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=USThr6BirQ1Nb85qv
	Z/xfwnowJtYK2cbqcvb5IMY0rU=; b=eOmTtxORpELaca5azYc/ROiH+VYBS7RQt
	Vptohp0RgjhBX1+/k0vlnNTxFoeqf095qlrlvUzVNDZlrJ7aDaOyRguf4PLzuQLC
	zh7yI+F/FGOHsqF2OVWvnEvkafdriHUktQpkpcQJkXaj00/nLFC7RSQoz0k0BwDX
	9tzVy+qYaFJszPbFSuxZDokIs849qBhjF1NfFLGiDG9VT0NRH2YPCBhxRj+vfnQe
	ChN3lcChBN0OyYg9Zn0eOPkU/duXdZiYzl3kDG3zONbFQJJLepd5gT2DiKQmaO+M
	PdY4rCPaVt+po5EzZB9NFWuyAWsL3j6VqsYm6xAOS2zA+NgnTUjzw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v2823s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYdhJ027575;
	Mon, 15 Jun 2026 12:42:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjxj1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgo2P51118542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE4932004E;
	Mon, 15 Jun 2026 12:42:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7602920040;
	Mon, 15 Jun 2026 12:42:50 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:50 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 13/17] KVM: s390: vsie: Refactor handle_stfle
Date: Mon, 15 Jun 2026 14:42:39 +0200
Message-ID: <20260615124243.187614-14-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXwhmLuxLkwhx5
 qwF7HMhAyWqaWtW1xlyGWOUSL4pcEHiqKVUagP94VNO+TZTD76Dpt8oCCIMfFZmyzOzxy7fEmTw
 BuqW+hjVWi5gh7ovv6wykWzi9+kNUm4=
X-Proofpoint-GUID: KkPfyXx9n0s6daCCfLpWp2SMdKbLQtwK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX2La28k37jsb2
 xU4tF/jfeV0+RsGO1r9vn30JKyHa2lW74k+KR4GJonAjz5V0Dq96ORmuaq6t/FzBLcTPmaVRhY3
 DVL0EL6Kic4/LUO8Wet195FsIq9F8iWfTjrBUTY2rC+vtsmXeYfc5nYz9ib9R7lild6BPqjEp+h
 N6rxu2XEbPfyrsOK3qqmYkTaNzA5L954nil35/20kOrUCx93RJl5PkHsLzxZWG502D4CXeGakqE
 gizqBDQucwb1CBlclX+0OCFeNGUVH185QXg9M2xA1oC4uX+ojEb8z2bb7x3G0QtygVndFrcLQmI
 bwq/vgMwToR4tgtiRQknFocKOCQhJuU49WkFgv4A41wHlnvtEmDCLHSri3B5i31yJyEoj0ik1kM
 MTRv8I8X2qFBqErhCy28dqS1shhFuwybXkCprDOJ+T/IQkFk25QIP4DA8S6qDaEvXL7MSo+wDFW
 pTnkH8l+ftmowq/zBfg==
X-Proofpoint-ORIG-GUID: KkPfyXx9n0s6daCCfLpWp2SMdKbLQtwK
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a2ff351 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=j8Ixm2VswuN3s4kyCd0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-20851-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pbonzini@redhat.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:frankja@linux.ibm.com,m:borntraeger@de.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18A3F68657D

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Use switch case in anticipation of handling format-1 and format-2
facility list designations in the future.
As the alternate STFLE facilities are not enabled, only case 0 is
possible.
No functional change intended.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260612-vsie-alter-stfle-fac-v4-3-74f0e1559929@linux.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h |  1 +
 arch/s390/kvm/vsie.c             | 53 ++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 60345dd2cba2..4192769b5ce0 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -444,6 +444,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_ASTFLEIE2	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index e5a23f1c9749..c7dcdd460dd1 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -6,12 +6,15 @@
  *
  *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
  */
+#include <linux/align.h>
 #include <linux/vmalloc.h>
 #include <linux/kvm_host.h>
 #include <linux/bug.h>
+#include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
 #include <linux/sched/signal.h>
+#include <linux/stddef.h>
 #include <linux/io.h>
 #include <linux/mman.h>
 
@@ -1000,6 +1003,23 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
 	clear_vsie_icpt(vsie_page);
 }
 
+static int handle_stfle_0(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+			  u32 fac_list_origin)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+
+	/*
+	 * format-0 -> size of nested guest's facility list == guest's size
+	 * guest's size == host's size, since STFLE is interpretatively executed
+	 * using a format-0 for the guest, too.
+	 */
+	if (read_guest_real(vcpu, fac_list_origin, &vsie_page->fac,
+			    stfle_size() * sizeof(u64)))
+		return set_validity_icpt(scb_s, 0x1090U);
+	scb_s->fac = (u32)virt_to_phys(&vsie_page->fac);
+	return 0;
+}
+
 /*
  * Try to shadow + enable the guest 2 provided facility list.
  * Retry instruction execution if enabled for and provided by guest 2.
@@ -1009,29 +1029,30 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
  */
 static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
-	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	__u32 fac = READ_ONCE(vsie_page->scb_o->fac);
+	bool has_astfleie2 = test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
+	u32 fac = READ_ONCE(vsie_page->scb_o->fac);
+	int format_mask, format;
+	u32 origin;
+
+	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct vsie_page, fac), 8));
 
-	/*
-	 * Alternate-STFLE-Interpretive-Execution facilities are not supported
-	 * -> format-0 flcb
-	 */
 	if (fac && test_kvm_facility(vcpu->kvm, 7)) {
 		retry_vsie_icpt(vsie_page);
 		/*
 		 * The facility list origin (FLO) is in bits 1 - 28 of the FLD
 		 * so we need to mask here before reading.
 		 */
-		fac = fac & 0x7ffffff8U;
-		/*
-		 * format-0 -> size of nested guest's facility list == guest's size
-		 * guest's size == host's size, since STFLE is interpretatively executed
-		 * using a format-0 for the guest, too.
-		 */
-		if (read_guest_real(vcpu, fac, &vsie_page->fac,
-				    stfle_size() * sizeof(u64)))
-			return set_validity_icpt(scb_s, 0x1090U);
-		scb_s->fac = (u32)virt_to_phys(&vsie_page->fac);
+		origin = fac & 0x7ffffff8U;
+		format_mask = has_astfleie2 ? 3 : 0;
+		format = fac & format_mask;
+		switch (format) {
+		case 0:
+			return handle_stfle_0(vcpu, vsie_page, origin);
+		case 1:
+		case 2:
+		case 3:
+			unreachable();
+		}
 	}
 	return 0;
 }
-- 
2.54.0


