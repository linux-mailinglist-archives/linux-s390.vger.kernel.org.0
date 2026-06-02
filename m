Return-Path: <linux-s390+bounces-20413-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XAiwJh8YH2oDfgAAu9opvQ
	(envelope-from <linux-s390+bounces-20413-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 19:51:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55539630DBC
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 19:51:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=aPPpHJG2;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20413-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20413-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 419EC3050279
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87F3FE674;
	Tue,  2 Jun 2026 17:48:31 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27DC3FC5C8;
	Tue,  2 Jun 2026 17:48:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422511; cv=none; b=HkPNKqAXaCofCfrE/BuSJX4acO1LweWLPAzYkxEE6vquY7eUCneXvrGqONQ5mIjNk3OClCwyj21/5W4lhbnDmjTjh/GEoeiH91UdtqvRycE2RykGZz8poRfcvlSrUrFzcp/2SHYYWFfh/Y7LIuSBUUN9eplVC3C9SfB4vs56UBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422511; c=relaxed/simple;
	bh=+caHEPkocHglJ/6Qs3dMJc7wqHb3W4gjWRSf5kUuSQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJQnGJXVIrORrcw/yKIpNoluSGAlj8uNMvzLJxS0nArE7vC7L/aq0EDnckG8gsPFoOE3lBkMGkuYh1EI5bEYkbJH/6ECL9QgMMxSLPUa877Hkvyz5YhSiD5SR+7WCxmEgPo69LxmJzT3iIA8LvN/7FA3RtqL+lrV7gLWUo8EisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aPPpHJG2; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6528S64Z2708324;
	Tue, 2 Jun 2026 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X/XZQ455iHlb+KxAV
	hLpzVf8kpN82k4w0kdjRhq8rS8=; b=aPPpHJG2Pb+8m8pIWj/jx9Yns1iSpkOiJ
	KdybFjoDs31zucSNGQScmN0ac+RsBMrcTbURazD26xm109dedEj4BT4VPzxqeRE8
	ReCKvJqGEU8t4u07XgnjygY4wRXEHgISuNybRDtGwrx0TVaGpUKTZt3Nzr6bMiUG
	CYmyXbfHP1mHUHpn5eoZbM85dUCvF4T6gnpksy4qg7GZfBwRS0h8xtrQ+KMtpAyD
	HQ3aXbunwESNM3vhHLjL6oLCK6DspbKdynnKP/v/v7uWwOu2mXEegQnijiExOePb
	3+4TZ5Pb4V/Q1ZApXq3dgUdxcLA+JptOJP0LlzfWDJlCjf6GRLV2A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahpyug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdQtH027932;
	Tue, 2 Jun 2026 17:48:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k4ek3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmK7r48955662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C53F2004D;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 601D42004E;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 08/10] KVM: s390: Prevent memslots outside the ASCE range
Date: Tue,  2 Jun 2026 19:48:17 +0200
Message-ID: <20260602174819.255785-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602174819.255785-1-imbrenda@linux.ibm.com>
References: <20260602174819.255785-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfX3ltIbtwGDXu8
 N7SOwJUymkX6crz3mFrrEr8zHTzxxMfUw7GPulDAIw9u803xhOYQHYjA6tq4VU3n0R8e+00IKe2
 1aiIfheq1RYWEyr3VxZrX7NN6TG8JApvBD+WatQDbSDyNsrvsBJWYDnq9E8lNnE0v8hQ1stXXoe
 q1HGlsiJ8mDPlrZBYhBb2apZAP9/uprlkiGw/vrBaJcDKRYlLr1K4bpT7YhKjyRN6GQmPAldfsc
 K3C/u6C9a3ZeZnmhqrgMSlxjASJyMMs5H8oZkSTikrlrC+hKzJTpXDkyUkor+0ZK6iA7indvD+F
 k62udydGTZmD4Jz0WZL+d8AhOV6bEApLVsbbCiJaiMQt2C4dIMif9EJOTwI1BtnKwLqEGbNhXOb
 HFuPPN+2XAiWfR8YbN4hhZ/EoQmOVqOt0pgqu8SWQPnDgcyfyiDMRL0tG8F59PTgCr0btaO/Ov1
 8Dok2QFaJMyb+4NAhGw==
X-Proofpoint-ORIG-GUID: yntBcTSgFkRsQkQ4k2Oo9x1iL498-k8m
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1f176a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1rJwsmJvMo9JdAIlmdgA:9
X-Proofpoint-GUID: yntBcTSgFkRsQkQ4k2Oo9x1iL498-k8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-20413-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:from_mime,linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55539630DBC

With KVM_S390_VM_MEM_LIMIT_SIZE, userspace can set the highest address
allowed for the VM. Creating a memslot that lies over the maximum
address does not make sense and is only a potential source of bugs.

Prevent creation of memslots over the maximum address, and prevent the
maximum address from being reduced below the end of existing memslots.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-9-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e09960c2e6ed..ffb20a64d328 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -999,7 +999,10 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		break;
 	}
 	case KVM_S390_VM_MEM_LIMIT_SIZE: {
+		struct kvm_memslots *slots;
+		struct kvm_memory_slot *ms;
 		unsigned long new_limit;
+		int bkt;
 
 		if (kvm_is_ucontrol(kvm))
 			return -EINVAL;
@@ -1007,6 +1010,9 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (get_user(new_limit, (u64 __user *)attr->addr))
 			return -EFAULT;
 
+		guard(mutex)(&kvm->lock);
+
+		new_limit = ALIGN(new_limit, HPAGE_SIZE);
 		if (kvm->arch.mem_limit != KVM_S390_NO_MEM_LIMIT &&
 		    new_limit > kvm->arch.mem_limit)
 			return -E2BIG;
@@ -1014,12 +1020,27 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (!new_limit)
 			return -EINVAL;
 
-		ret = -EBUSY;
-		if (!kvm->created_vcpus)
-			ret = gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
+		if (kvm->created_vcpus)
+			return -EBUSY;
+
+		ret = 0;
+		scoped_guard(mutex, &kvm->slots_lock) {
+			slots = kvm_memslots(kvm);
+			if (slots && !kvm_memslots_empty(slots)) {
+				kvm_for_each_memslot(ms, bkt, slots) {
+					if (gpa_to_gfn(new_limit) < ms->base_gfn + ms->npages) {
+						ret = -EBUSY;
+						break;
+					}
+				}
+			}
+			if (!ret)
+				ret = gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
+		}
+		if (ret)
+			break;
 		VM_EVENT(kvm, 3, "SET: max guest address: %lu", new_limit);
-		VM_EVENT(kvm, 3, "New guest asce: 0x%p",
-			 (void *)kvm->arch.gmap->asce.val);
+		VM_EVENT(kvm, 3, "New guest asce: 0x%p", (void *)kvm->arch.gmap->asce.val);
 		break;
 	}
 	default:
@@ -5672,6 +5693,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
 			return -EINVAL;
+		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npages - 1))
+			return -EINVAL;
 	}
 
 	if (!kvm->arch.migration_mode)
-- 
2.54.0


