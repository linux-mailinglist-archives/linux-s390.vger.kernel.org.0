Return-Path: <linux-s390+bounces-21219-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RZxQAZO9O2pDcAgAu9opvQ
	(envelope-from <linux-s390+bounces-21219-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:20:51 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4336BD9BB
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:20:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=Nnk5BDaA;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21219-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21219-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F789309A666
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90DD38D688;
	Wed, 24 Jun 2026 11:19:41 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209B364953;
	Wed, 24 Jun 2026 11:19:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299981; cv=none; b=c6rTAKZlHzb7LkZNBiG91xhr7qqAywbQVZE1byLnOF+ucks92mwqmWM/gnhqE9u65eMy+ypp84IT1YXgIq2rK0awBaVNV3ipBVONJee//GCMDUhgFdcj9D3HBU9EZGSC3g/zP/Vm0oTQRFl3pOc3qAcg6p7aZnCX3xUd0Lijz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299981; c=relaxed/simple;
	bh=ZKE1tR1ORcSfKo9zZ/woQMBWzdqTZ/td57McTis6EV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJp+v/j4CP5fBRFrXnAkfhHyrDbxocdjQjZtaBzx8GwGMqdH01PLXSq6w/0M9RW9RnZl0eHMqUKukg+9gTjAh8zN5JWD9+OZQDaVXIYtqGWhlpRAfbYdI3ibZ5uqw0biboJK5NNIRCCCkb/Rz1Gqj9SsYpYGJQ9T3IB47EslYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nnk5BDaA; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmRg6718050;
	Wed, 24 Jun 2026 11:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6rCspicw7DaYG7t0a
	cEtteh90hNs+SbwCCzgPOEJDYA=; b=Nnk5BDaAZhTfsdUAID79uEoltIWmPQ5Rv
	7nBoPbkxv671sbcuXMN5aRvxDS6JFxqNw2x3XumY7xTQJ22YCdvZpc+E1WAeAJ9q
	8kPNzpmyX3Ki/ggX7dmM/ONMgw+/v0pFhiM1WGNYUjeoCGTOAdZTYGl1erxmGkOI
	36GjbA141Nd3bON1e31oCD6CgTT9B3sfYIlPqPiZU581qZHj+6/P80tBTvb9fVQD
	eh+D/0XleKK9VA07cRE46wDGx7ci+hFuuxUQH0sZzHl3fZvmtzPMOS6KGHUjw9Ps
	MY9aeYfR+EBOSddNGlwGijTvZsZUl9fpLjeNLpfVmrlyPxR7dNiYw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3kv5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4gKT001543;
	Wed, 24 Jun 2026 11:19:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k88ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJUhw38011320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B6E720040;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 208302004D;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 05/12] KVM: s390: Fix dat_peek_cmma() overflow
Date: Wed, 24 Jun 2026 13:19:21 +0200
Message-ID: <20260624111928.144283-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3bbd49 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0SZZOaMt82sS6LYugLYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfXxFzQXF380ouT
 4szB9G8Xc6+Mj8twOjSg8LsobpYFI8KRONOSE93E7qT1D2DSA/y5LB0j2gi5TB/grhbV4uTGEBy
 iKrXHuFn+DeKIq+XgeNdWE4Uhvx3Uk0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX8AuyLN2mSoq6
 +6z6v7SZ/bSeKIZ3lux2RDC9ztt+jXLOYbSErfMz3w/WacZJ+pjU+ycWKaYW+eerWkqvw1P8SY7
 bpyK1lJ9nKK+kDtWZHqTB6yarCj27IwnRpxWIz+WA+Q/FXln2WugBg87BzWRQueINzIyEj7MABa
 khJab3UrJLl7nV4+y8rKT6fG1LBuT+CfuDRj2pQQ7n2aYtM/9CEOjESeNKO+8wyDDBt0VEGTH+b
 vrkZyBiHcmDlMSiLWIeN0acvwBpVbs/0hN/5F1VkFkicai4YNU8j2mZcZIt+aBkdrwUUTasoFSM
 aoxesOtSzcr5z8IKBAqw0HhJyWALVY3YXVjjuCEgf3SROULrnKd1Tpv/7vmMCbedIKbS6Yusz5G
 pXvKN33gwB2d8rYTBuQ8ZCVG3h2UNg==
X-Proofpoint-ORIG-GUID: 41AgCub1WxcueVlOwv7l-sM2g45k4-DT
X-Proofpoint-GUID: 41AgCub1WxcueVlOwv7l-sM2g45k4-DT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240094
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
	TAGGED_FROM(0.00)[bounces-21219-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E4336BD9BB

If userspace passes a start address that is out of bounds,
_dat_walk_gfn_range() will fail with -EFAULT, but state.end will not be
touched and will stay 0. This will cause *count to underflow and report
a very high number, and the function will end up erroneously reporting
success.

Fix by only setting *count if the end address is not smaller than the
starting address. This way invalid starting addresses will correctly
return -EFAULT and *count will correctly indicate that no values have
been returned.

Fixes: 7b368470e1a4 ("KVM: s390: KVM page table management functions: CMMA")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260623153331.233784-3-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 4a41c0247ffa..cffac7782c4b 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -1209,7 +1209,7 @@ int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values)
 	int rc;
 
 	rc = _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_DEFAULT, &state);
-	*count = state.end - start;
+	*count = state.end >= start ? state.end - start : 0;
 	/* Return success if at least one value was saved, otherwise an error. */
 	return (rc == -EFAULT && *count > 0) ? 0 : rc;
 }
-- 
2.54.0


