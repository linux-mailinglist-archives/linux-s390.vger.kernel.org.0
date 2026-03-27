Return-Path: <linux-s390+bounces-18253-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI+KDw2ixmnrMQUAu9opvQ
	(envelope-from <linux-s390+bounces-18253-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 16:28:13 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9883346BC5
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 16:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97CE630C8738
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CEF330324;
	Fri, 27 Mar 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mQF+1J1P"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B621334685;
	Fri, 27 Mar 2026 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625056; cv=none; b=GeCwTA7xg+N5+/JykEfIlC/8NxWL5BKKP8mrZmJRPx5wGVfYblXDMiSpnXRY/5e56QlFRkb2hPpY9HpYMAqpMlgCIP5haSFhjzuWlW5vsuprmLpEoXnSjhHUGNZHG9kFQ+jqpqIt/OiVwW31XJtGXXFsRhX31/01QVW50Iw00B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625056; c=relaxed/simple;
	bh=X7SYUAwgEUb8ENh50wutCoe+NSng9ZMGrUXFWG7T4JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZ9e+NG53a1vYftN8Vz9IIq9Cx1zEotUWmaZENncnZmP/i0ynxLv8UJrKNA44azjTLOnBlM6C5EZ7jOoKNkXj5gyauUIXZ+b+6LzlRcylmw8x1XkAuclGoIFfavUkv9S1Zqt1JxHplxDn80/8Qk6ORZPZEv+/zGh1WZui5rQy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mQF+1J1P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R2xPqt406889;
	Fri, 27 Mar 2026 15:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7JC2kiQlD0AFSTDl0
	wACfSg/g6okp2Wfal1MQfmP56E=; b=mQF+1J1PVhAjKrc7PaBLihnWSquL7hYmA
	iDiPK9dua9wV/xSeU5E/jSqV7DaE8hw4eOClcztlFiZxgmL8KllajfQtWlKF1x1A
	VUbhARkjAYjuF3oB4tm1BDSEEGFQVzy3uJLHDa8x+uxa8thfirjccVRRgKCt1koJ
	RzpXHLHXtz+iOTIr+/AQkqOZiI5Olz+erEddQM2//Qos5agQb3LZETicKUGN65E6
	tdgrUexlBYnryDn3avB372R9WOQY8HI/spjGjnDqDJGT/jN2avp9+5YpURHI5wri
	hDaMSK7PJ8ZmzUVqgtTOoMD3HNW6M+zbfEwcGkJkHLEsNFAdpXPzw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqtw11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RB8evD009115;
	Fri, 27 Mar 2026 15:24:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26np0198-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFO5J546399784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:24:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D4042004D;
	Fri, 27 Mar 2026 15:24:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A21B20043;
	Fri, 27 Mar 2026 15:24:05 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.84.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:24:04 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 10/10] KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
Date: Fri, 27 Mar 2026 16:23:56 +0100
Message-ID: <20260327152356.250625-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rBN1SFZPFVK_41jfspriQYS8LvMNPkhK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX0mTPTDCYjaOa
 lQDe+ngaBTLuAdzIQAt06ExAgFb50NfoujXFaQuhbCbrrhi1fwYhB6PCUuKmiG4/IHIDD28Jd8E
 WWmzeuZlGoVhOJMcAYCZ2BRjJeMfRfPqJwKkov2QIFSdiNbOM0Ypcq+Mpq/8ZQCZ+/fay3kA9K1
 GUwS/ClFS7ir2SXY53LDXTCS6ryjXp+4uUEvf8TT8mkwSGUWSnmqwWW8VWje9HsOwWIwdwRHAfz
 KGvxy8/bBQ3YGISkEroUbe4FjgGknfNzO06JjJuopjEsJ0LuhpQhH9ZZln1TvZyh12Vct2+Snsq
 9RS6FzQF8CvfkOmMWC+KDhoWzYrXT7dL2mP960iK7w2VIpTH7MY4+bcw5JSMMud4BnGharvZIYD
 aY0f/JaQ08h7Q6iSydasqY2OoaF4WkH7/64w8hHjsZeaSCKf7mBefNcx1fNgwLbmlEfSyU97nkD
 6ApvK9geD/MSyoeA75g==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c6a11c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ikv_JcFPPU8SThzKSe0A:9
X-Proofpoint-GUID: rBN1SFZPFVK_41jfspriQYS8LvMNPkhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270105
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18253-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: C9883346BC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A previous commit changed the behaviour of the KVM_S390_VCPU_FAULT
ioctl. The current (wrong) implementation will trigger a guest
addressing exception if the requested address lies outside of a
memslot, unless the VM is UCONTROL.

Restore the previous behaviour by open coding the fault-in logic.

Fixes: 3762e905ec2e ("KVM: s390: use __kvm_faultin_pfn()")
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b2c01fa7b852..d7838334a338 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5520,9 +5520,21 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 #endif
 	case KVM_S390_VCPU_FAULT: {
-		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = vcpu_dat_fault_handler(vcpu, arg, 0);
-		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+		gpa_t gaddr = arg;
+
+		scoped_guard(srcu, &vcpu->kvm->srcu) {
+			r = vcpu_ucontrol_translate(vcpu, &gaddr);
+			if (r)
+				break;
+
+			r = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(gaddr), false);
+			if (r == PGM_ADDRESSING)
+				r = -EFAULT;
+			if (r <= 0)
+				break;
+			r = -EIO;
+			KVM_BUG_ON(r, vcpu->kvm);
+		}
 		break;
 	}
 	case KVM_ENABLE_CAP:
-- 
2.53.0


