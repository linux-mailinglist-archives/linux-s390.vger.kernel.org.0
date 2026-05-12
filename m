Return-Path: <linux-s390+bounces-19598-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fz7NvtrA2rF5gEAu9opvQ
	(envelope-from <linux-s390+bounces-19598-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 20:05:47 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CA4526BC9
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 20:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2404312E7E6
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D413BB108;
	Tue, 12 May 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="as2tMrGu"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC873EDE7C;
	Tue, 12 May 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608384; cv=none; b=WmqfUTlYu3/dQrHt4Em3pwCzGJkSYP5p1rPjM2Uen0tRijp+318imE47XeZzSWtW9Nou9xsOugx4xoP8F1kvDPE6auMaHP4Kw+Rb0C8lR9JDvxB5AYgSt16ShBr23X5S17lcvyo8O44vBlcbYiEHP42ER7S6oxmhWDmCb5TkM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608384; c=relaxed/simple;
	bh=x0FONrt88Hrf/qHe1kaa7Z6+djuSeV3TQhd5jWrVqao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSv3AcxO9DKxiIQNyaY36f79L+4KeDvRVVGV6lFXjMaRru7lX6oLVcxLswf3e6UpCzVkHDKfqatwfX7fISfxt+zblNP7oiFxWfSO+94l0z52Ix9KSH9USaJeAQ5XKrXtorwu9ti37UWAX6idK+ezojpjXaj5Y82nxDRRYkk3I7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=as2tMrGu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CBnmm83775519;
	Tue, 12 May 2026 17:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5gbxR3zg+u2dD5c50
	k409xH9BWbQWgWS7FQFn1EUjTg=; b=as2tMrGufnTlHICwz3s1UzxucoKRz51OS
	2J8cC6eZu4N3VudVBDhaXz1o3RxQO344I2vECvWoYeoglVgXpILcraH5CfRChNQy
	ixhGS+tnoEtaJilaPTNSBeJCefomfZkznJvbf6tmGPQSVCDYRtKeZiVmT0ufnFGB
	E2Ze1q/AoN9UvCroxFBANDUNc+TzaiUKy134062sn0/vnZQlrNDU+ky9AuHBVjkv
	9lYTC9NZVctyENukj4UJoLz+QWXClfV+FUTGAfVF4ACb/jLJgZFKPFQkvfw7Ye3b
	GnfDbF+l3rWkzUTdx0iaX3c2KvAfU3upWN4MP2hQ0YmRPG5wWxvOw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6m52u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHdSj8031390;
	Tue, 12 May 2026 17:52:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgm8jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CHqrXb61538624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:52:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 106B320040;
	Tue, 12 May 2026 17:52:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEEF92004B;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 4/5] KVM: s390: vsie: Fix redundant rmap entries
Date: Tue, 12 May 2026 19:52:50 +0200
Message-ID: <20260512175251.300882-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512175251.300882-1-imbrenda@linux.ibm.com>
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a0368fb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=7eV5o87doowNvqF6OWkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MyBTYWx0ZWRfXxWtF9bDN/GJj
 VjHYyQHXmZH+Zg3d57pR7GAcYM29gjNBWEF011qEVnpMlXMIBV4jFKAIdSH5t/vcOUFmhDUSZmN
 gx3OWsAZB70xfJCYKJ7RIypAIES3mnpGkGIJsvrA676eLYNFhlgmP3F9s105z8xBLhwYw58zuxL
 zxp8FHfgFHYNSvEEOq93D6g8zcjgcRWtWBgUO7re+vNr8airWGnAZzy5uovg1b3mgkc8C9TkMx0
 5zaav+xOJcM5i/jEbV6J7fcI2MXe+UacUgVePClo0hSzDwkCihySZ9P5+cvnLBKCOxTx7vpUDN9
 lFgYceyxc8mvhI9Z4hPdstW2xPTIXSePtATwwgtbPXs3S13+NoJznWNGt1AtErbUHlK2XSiP2S/
 oQvcsPw26hwegQgnINsjGYgikIsWc3mw5YSTquYv2BMri3hB7oRaUXXQhLF628/aJjC4EOmC4VS
 P42EwOPWhxMJCycdF9w==
X-Proofpoint-GUID: obtepszRLazhP0agToY5014-2d7cOLUo
X-Proofpoint-ORIG-GUID: obtepszRLazhP0agToY5014-2d7cOLUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120183
X-Rspamd-Queue-Id: 89CA4526BC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19598-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-s390];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

The address passed to the gmap rmap was not being masked. As a
consequence several different (but functionally equivalent) rmap
entries were being created for each shadowed table.

Fix this by properly masking the address depending on the table level.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 8cff0cf5ce24..957126ab991c 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1025,6 +1025,7 @@ int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int level)
 int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn,
 		      kvm_pfn_t pfn, int level, bool wr)
 {
+	unsigned long bitmask;
 	union crste *crstep;
 	union pgste pgste;
 	union pte *ptep;
@@ -1041,8 +1042,9 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	if (rc)
 		return rc;
 	if (level <= TABLE_TYPE_REGION1) {
+		bitmask = -1UL << (8 + 11 * level);
 		scoped_guard(spinlock, &sg->host_to_rmap_lock)
-			rc = gmap_insert_rmap(sg, p_gfn, r_gfn, level);
+			rc = gmap_insert_rmap(sg, p_gfn, r_gfn & bitmask, level);
 	}
 	if (rc)
 		return rc;
-- 
2.54.0


