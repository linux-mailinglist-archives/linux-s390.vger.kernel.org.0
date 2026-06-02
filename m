Return-Path: <linux-s390+bounces-20414-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3j40IC8YH2oQfgAAu9opvQ
	(envelope-from <linux-s390+bounces-20414-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 19:51:43 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09406630DC8
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 19:51:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=WDb+Ij1C;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20414-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20414-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EA8305A85D
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206B3FF881;
	Tue,  2 Jun 2026 17:48:32 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBDB3FCB2F;
	Tue,  2 Jun 2026 17:48:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422512; cv=none; b=aEFcjyqeI7eryVh2QRGnlgtKLXRdUqjWg3RvhctkNbd7mMti8mYZOYf+5KRIhgsXsIJv5CwCqBl/zfXHK56KsB1l2AbDdaYouLuvg8W9TKs2wCrUvIFcOgtcbtPLPCEewjErmUya0GBQhqdBQdv1QZ1iltLgk+nE7cpL9i9DFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422512; c=relaxed/simple;
	bh=Z1mFUrk6as3+cPisYBlVJC+frazE/czAPCfRrt2BkqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7W0a5IYM1eofFC2AdRm3WLCedJEer5e7LcEL0ABXj6gmak+TCXGflsoIH8H7+o3tZeGBb6/ysTXq7L1AOdrKSFgXbc8RMwrFiNfXLMv2lazzIgEL6iP2JPDYkdOO/14AVVVBIN03lbASCYs+7Cn1yD419Gy3yspFrZ9plXcxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WDb+Ij1C; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652E1q9L3195132;
	Tue, 2 Jun 2026 17:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UQVFFMTk2zqu2R4E3
	TMIB+ldSuVPV4x143zmXDlhuoA=; b=WDb+Ij1CaziPTm3K9GEPZirjwtwmlqxAK
	/oktVVU8boh79KHGjL6C+cSof5e6WVSY5l1JGpcYMpGq+zioVYYKib+No1aX7NyP
	v6D7AZtDLtQjjNPCqjwvjYDu4+EKWyDu5U9xskoCHwWc5ZGcjQuwUGoV0KBI+urq
	gY/1icp7rAAZTbOyOog3ggEqJUZU09EFFjNVa4M4Qjo7bKovuRUyXv6+1wsgl3uV
	lHCJTHYLdVy8TrjLKhpsviZoTQ7je2gqT6N1n6ityae/M4+c0hXHnJdr6xC3ruPh
	WHVa9lpYtTCg6dUKV8+OHNcl4YfJ/UrkLJTDTIqOrJOZsXqE3XHSg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht6qqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdPj6027929;
	Tue, 2 Jun 2026 17:48:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k4ek0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmKgb48955652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1609F20040;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED1132004D;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 05/10] KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()
Date: Tue,  2 Jun 2026 19:48:14 +0200
Message-ID: <20260602174819.255785-6-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: ihhciJsp8e1N_i2EynfYSGHS37jW-mp6
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1f176a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=sChW5zZnIGAfqb-v-YwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfXyXrWSVGhY2vP
 HeougMACZiKP0KKyxXAEK7NlkWg58V9t2FLpg/HvMyuINplFmgX15vjy7wMYdNcrR6dskEp0xiR
 pNSmgr6PpQtyr+lPSnVJZlS2aAQdM0ccQISjofxg0M25WomCEm3GOONG4pdg8pAJh8FKUFVlVHh
 zi3P3hRXZPCKNylh2GBI8y65IwBWg8IFoQoLdib5iP35dY0pOeqymD4zx0kjWShv9eO9D1W5c/j
 fl2dFOs/ZajUcyBKHG5O6IL0YfuTEN8hcRZyqZZnJIUPKVitskjcR1Q16DPZRQanJnyh7iaYcEB
 s9VgLOfNqVONVDsNQLEgL18efcOgyV40CghJSOwgkfRi0Tqkz47whXb3bLWA3ytnHkvTNfE8UvO
 igw79g0H9TzSfswstKiUD0RD/ynFaDDsKo2uS0HJTp6blxvtEkDotanQ1AJSfWlbXM8FHAPFRI4
 52lUQo3lw5LyMwpKhiw==
X-Proofpoint-ORIG-GUID: ihhciJsp8e1N_i2EynfYSGHS37jW-mp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170
X-Rspamd-Action: no action
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
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-20414-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:from_mime,linux.ibm.com:mid,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09406630DC8

Fix _do_shadow_crste() to also apply a mask on the reverse address, to
prevent spurious entries from being created, like already done in
gmap_protect_rmap().

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-6-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4f8d5592c9a9..20e28b183c1a 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1466,15 +1466,17 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 			    struct guest_fault *f, bool p)
 {
 	union crste newcrste, oldcrste;
-	gfn_t gfn;
+	unsigned long mask;
+	gfn_t r_gfn;
 	int rc;
 
 	lockdep_assert_held(&sg->kvm->mmu_lock);
 	lockdep_assert_held(&sg->parent->children_lock);
 
-	gfn = f->gfn & (is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK);
+	mask = is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK;
+	r_gfn = gpa_to_gfn(raddr) & mask;
 	scoped_guard(spinlock, &sg->host_to_rmap_lock)
-		rc = gmap_insert_rmap(sg, gfn, gpa_to_gfn(raddr), host->h.tt);
+		rc = gmap_insert_rmap(sg, f->gfn & mask, r_gfn, host->h.tt);
 	if (rc)
 		return rc;
 
@@ -1497,8 +1499,7 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		return -EAGAIN;
 
 	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
-	gfn = gpa_to_gfn(raddr);
-	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, gfn, sg->asce))
+	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, r_gfn, sg->asce))
 		;
 	return 0;
 }
-- 
2.54.0


