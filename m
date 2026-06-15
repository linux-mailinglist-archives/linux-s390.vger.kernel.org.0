Return-Path: <linux-s390+bounces-20847-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AvTUHZfzL2rtJgUAu9opvQ
	(envelope-from <linux-s390+bounces-20847-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 14:44:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E9968658F
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 14:44:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=m5SP7afy;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20847-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20847-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E2B2303D35E
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737593F23BB;
	Mon, 15 Jun 2026 12:42:58 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1413F167C;
	Mon, 15 Jun 2026 12:42:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527378; cv=none; b=OyH0bvm0bYzQbquFhhgZOZov9MnvMfS/8etQlL64+nKBLiWiMdANDADUhjJKMZW3shKRVJJAMm2cj2YmWnD0I91L0iLl3mnxabdvrIQj72rjzhiWoCPigKzxcCx29+S9A3kQpwjgc1hxGIQmgIq8VsEQpSi2MriaAne8KxAV9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527378; c=relaxed/simple;
	bh=S+qoc0xSXPLcOsGPeJsIfztUlcRzS4tT43+4ZfkKz54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biP6ZfrJHMFNKjcgBMIAQkaSQAgmdTTpyYXsY9WizXhG53bVGvS/g3OC2zNL7DfNFwSKwyCBCzTwZKyehHuJ2oNM0ZjwuR7CwAEVAY1mViAsOBNP3Xu+VCzIPLR0wlZ+k/v1yIzQRnEPp/ipSsc2J8vJ2OB3R1SfbgWX8QLor9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m5SP7afy; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAqN0S2249064;
	Mon, 15 Jun 2026 12:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YLDhMTigz3A6DgPCV
	v0tbkslClo62uu6u0fm4Wnqhpo=; b=m5SP7afyip5xqIWgZMaTzyieRuWjwu+Sl
	E9tqMXcarm2q4XBhhzh1soKHGKa/xnv0F5reoRB/0VK+jk1uo1MTGEYEs4MmxTQm
	p8KxsSTp/dSdZIW8WYtuH6HWh6oLmXjYV7Aagq+6wy6J1IyvVZklq8OdnBQwvwEz
	mPTV35LGipUAtaoweNuj6cYW8eb4k9/UrmJwHp2JTsn0s4Lj0k57Nzgpi5CKS2aR
	poc1kP48GPovD23BVLGcg8BFTGwhq0JjJXz6wih1IgTnECmXISjmwFiOsP1d4T3R
	92cFxjG0leJb2jRp94BLn+gKPTuYhv+ju9FkBnOGfd07NPuqQ6CaA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0g2ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYuXD025626;
	Mon, 15 Jun 2026 12:42:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1gxgmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgmtu52101574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA64C2004B;
	Mon, 15 Jun 2026 12:42:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5183520043;
	Mon, 15 Jun 2026 12:42:48 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:48 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 09/17] KVM: s390: Document the KVM_CAP_S390_HPAGE_2G capability
Date: Mon, 15 Jun 2026 14:42:35 +0200
Message-ID: <20260615124243.187614-10-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: UFfz7m1K9cI-gPdu7VgYjOiZn38_v6Gc
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a2ff34f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=57WV-tRym_uPHXD_bOIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX9/cN8CAb9R6o
 Y03xoA6A/3Yc4Szs9GCl4TT5JTvzvzlZtAWPMsg3O/2Mk3SQnEzw1hdnRaYuQtB9SXqwNeh2mPt
 BkwzIIJGSDkTou4p3oUa5JBTwvz4/u7mPe2063EemFYjUR8BmhxKoso437PKne/LMWUa2ZLK3HB
 gEhOBxfuaa4X74UMOjJ0H+L1a70LlpI+WtyQQX+kvuBFWb1dBd4RVdtrW/oIg2XLSEleVuCW75Y
 H+707dw77dyjaSYMUEIWJauGKBQ+iY3Rae4jEXnYNV+I92lg+jYY6RkL572Ardog9iCBN6dYq7x
 t8s994wtFtF2/s+6jgh2C0VJsqIYYT6cMXOlTNYczhxvrM9N/wSLXLyfACmLPbdgFX5AdkdUssQ
 0vhnpgos1vvIsctMvFf7tQkceG34M5i6puzt4qDGHPFBFEakYXMyOlMkkx0oTXVPlof2m2xpjsI
 sXkb7QJd28zPMXGNIhQ==
X-Proofpoint-ORIG-GUID: UFfz7m1K9cI-gPdu7VgYjOiZn38_v6Gc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX8MH0TDd1SlLq
 zn3o5FOkRD7MRjEG7+v+KsdyXYMwUmchmo99KEzQIwuIA3cR01xCcHKLiCNll4Fo6+BGiQblxiq
 Ik4SI+qu3TfFM55KNSgL/VLEYeF3dH4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130
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
	TAGGED_FROM(0.00)[bounces-20847-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7E9968658F

Document the KVM_CAP_S390_HPAGE_2G capability, which behaves very
similarly to the existing KVM_CAP_S390_HPAGE_1M.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260609150930.665370-5-imbrenda@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e7998feaa940..dfde0bfcbce6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8905,6 +8905,21 @@ helpful if user space wants to emulate instructions which are not
 This capability can be enabled dynamically even if VCPUs were already
 created and are running.
 
+7.47 KVM_CAP_S390_HPAGE_2G
+--------------------------
+
+:Architectures: s390
+:Parameters: none
+:Returns: 0 on success; -EINVAL if hpage_2g module parameter was not set,
+          cmma is enabled, or the VM has the KVM_VM_S390_UCONTROL
+          flag set; -EBUSY if vCPUs were already created for the VM.
+
+With this capability the KVM support for memory backing with 2g pages
+through hugetlbfs can be enabled for a VM. After the capability is
+enabled, cmma can't be enabled anymore and pfmfi and the storage key
+interpretation are disabled. If cmma has already been enabled or the
+hpage_2g module parameter is not set to 1, -EINVAL is returned.
+
 8. Other capabilities.
 ======================
 
-- 
2.54.0


