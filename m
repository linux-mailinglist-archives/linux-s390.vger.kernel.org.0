Return-Path: <linux-s390+bounces-20696-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pB8fAmg5KGrVAQMAu9opvQ
	(envelope-from <linux-s390+bounces-20696-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 18:03:52 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F636621CF
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 18:03:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=fYnw4ury;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20696-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20696-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5DC932060BA
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E35480DF7;
	Tue,  9 Jun 2026 15:09:50 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F632480974;
	Tue,  9 Jun 2026 15:09:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017790; cv=none; b=BwEwWRcpugDMp5BKq6K7dF5lMdbBkTykCp+2sZlu1v4PFXuuMEQKX9nzYQ3b+zcvEefheBybYq9GSJ90AiCqRpkQfDqS/6pRbm2Mpya8xJxqr1mUgPTa+DzQzUvnF+uBuuSsbMQ1EjEqM09sUOgOrofKnSPtGQ9RlnV7Y7Ut6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017790; c=relaxed/simple;
	bh=p/HO13jhjN9jw8g6tCIAa+1t3BjP2zBPx1VNbMH9X48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKlTVyM3D3n7XSjC35vMzjdaOJo9lT1eTnL/ngCDYYQcPoNABQ1NIcLdX9jda+rlzCD3VNFHPBwVfcsiY1GZp0xu6+jdX9XCGobie9rTLbuPolfEOcQDAmNxvU1M7OWaf4jz4/in8cnPcAjBAuwBeHhwcbJjsbbIQZn3dQmKPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fYnw4ury; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659DfMlR3640226;
	Tue, 9 Jun 2026 15:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lNtoWBpn0TJrkcNgk
	dctwDLGEIQRUBry3xzJ/4rdFCc=; b=fYnw4uryk7vMzwFK/4Mw0AuRRGOBuv25k
	YdCaIP2/ILI3cdaQS48kfbZSXiFKs5xB/3Df8a2KH3Y7/A+4tvbMRme/F0/++pYL
	UGhM5y+YaGSCWf0gaFhX3FIXoAB1S0zUOpoJnQfYd3mtDn1F7vF5w5wPshtbXcMP
	j+QBkNeRycwI5viiQzxsoSWvodkd5BNA7UdyNBriu594fdDClbJ/ui0F+xZ7F6iV
	gaBGX1JBz0HIdZvZqp+mLGyVz5UbG+mKZfBB1A7DnWHLCfM2liy8Ku/UHpoDAoO6
	lfXHDBYTJP2XHGtlG3XNHQGj32LQWgZlCnNllk+zIDOrXb5iTwp2g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye4mhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659F4dfG021047;
	Tue, 9 Jun 2026 15:09:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjth20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659F9cvP27328824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 15:09:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4BAB20043;
	Tue,  9 Jun 2026 15:09:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4324F20040;
	Tue,  9 Jun 2026 15:09:37 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.28.58])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 15:09:37 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 4/4] KVM: s390: Document the KVM_CAP_S390_HPAGE_2G capability
Date: Tue,  9 Jun 2026 17:09:30 +0200
Message-ID: <20260609150930.665370-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609150930.665370-1-imbrenda@linux.ibm.com>
References: <20260609150930.665370-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NCBTYWx0ZWRfX7aCWuT0Fwc0k
 WgpdDRSVVy2SjFjlJ2A08V8eY80z0LT9V9JMTe7aMy225IYXjFtzBG21T2+OZw/pIWj15AZO7/9
 rg78retPkfHA2qng8KJ2Gsth6R+Ymq33fGkIrt/LjkyAKb7Fz3iZCXq0QJhaAqbZ8iLFMi5zDOZ
 iyls63L528zmNZFDeVrLddgmyxptyaSGL4viOTUmVZHmBFR9MrMfsCWT2J7CcFvik8a+BqYmJZt
 qCMhOHbmtMp4TiDG6ZEhET+Mzs0GSh17Ql9uAwvWZiNoQK4GCFjWV+TgY6zIoUfcu0bsk114NR7
 GcUA8Od+P5otFzATj2S3Mlix7VdgPzljDJbKe4wRsh5L0EoMocGlXN5weWNBUuodpChdzd+zghA
 TJCNvMtdfoENxP+oAcWS5Y9oOq7ywX7BTBsEmhbJ4vpDlmb17uhHtamVPyLv7i5iukcBXqJ64o1
 GTat+4gU3TO4WGZP9bg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a282cb9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=57WV-tRym_uPHXD_bOIA:9
X-Proofpoint-GUID: I7iBfI8c1OwdOehNMW6nQ4JAQyFvUnCB
X-Proofpoint-ORIG-GUID: I7iBfI8c1OwdOehNMW6nQ4JAQyFvUnCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090144
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20696-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13F636621CF

Document the KVM_CAP_S390_HPAGE_2G capability, which behaves very
similarly to the existing KVM_CAP_S390_HPAGE_1M.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..3fdd0729f6ee 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8904,6 +8904,21 @@ helpful if user space wants to emulate instructions which are not
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


