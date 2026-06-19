Return-Path: <linux-s390+bounces-21021-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nOrcOLjzNGo3lAYAu9opvQ
	(envelope-from <linux-s390+bounces-21021-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 09:46:00 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6336A46C1
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 09:46:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=pgkyx4pl;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21021-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21021-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6E23028EE0
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4372F7EE2;
	Fri, 19 Jun 2026 07:45:49 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EFC31D72E
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855149; cv=none; b=CNeLCUAuNlp+k58EVtmru2782JVFqJvYyy3/W9AZtdgb5ctlRdBH8UUKcHFX/Wu4nLPQvyyaiwGsZwWOPLnNYN56BOva20qaWZ1N1PDsrKB38Fei6cSNDVTmbb0SNXScM38MUGUftTlfTvbcv2kZyMtXE4oPYv43f8FEr+2oUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855149; c=relaxed/simple;
	bh=nqQunlRIyhaBZSM6/TOP/Ad9s5bgkgoEPp/ozVRi/PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzqRg99Cv3pn/DMIxHFkiqrNY4C5me8r74joUV6fzOzQHfkkLHgvzn8h/vFPOYVEZfQL455YcREUcRPveA0usDsknH8IOrihuk88QGzWaz718xIAObi6nQd5vU9UNCwEG8/CwkWUFUzE6AXM9dmQUhfVj0UOtdKHF84EOdNwxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pgkyx4pl; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3IDAZ1283337
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qZDESiCjgcV2GWRUx
	H7YG6ni9hXX/ogeb8arChnpRJo=; b=pgkyx4plVhvUNjSn5Fq5NEaU26/mpVLdX
	4Xujj3ZBiY58noEtTYuyqq1gVhtBZt8OeUPD2LqoSRUX91a5ZY8QJYj7fwzwKPcu
	M9YRphKqx6QDhenkTc8kt2rm5AXq/2tlMyUKAfiaKTi7oT5X5KrUPGfuoJX0ztyV
	y4JS7F2oRVSL6M7xjLM5d53aqDcknlEZzDPAmMx9zV2fOnSAPnUWBYK6nwhptKKd
	+BzyktB/3tMA1vjlp04QThTY7nEQUd52pe6dd3W4BhOiSb4bZ77oTOdbg8JFYOp+
	/Lg8KYHi10iDRkyKaCnDNcMVazP37yr9OHf6IAs7VveEhplaxYp3w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequcceu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J7Yudp030010
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1727stm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J7jhki25690526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 07:45:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5335120043;
	Fri, 19 Jun 2026 07:45:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF66620040;
	Fri, 19 Jun 2026 07:45:42 +0000 (GMT)
Received: from ibm.com (unknown [9.111.75.212])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 07:45:42 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl
Date: Fri, 19 Jun 2026 09:45:41 +0200
Message-ID: <20260619074541.1710716-2-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619074541.1710716-1-dengler@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA2NiBTYWx0ZWRfX+ZBSv7zN5iAs
 c9H+Fm7Vt4hSbADB8w5qagKnn9cjDG2EuGTpNP1K64h/fT1pjaHfN29AT4GWBYKuZUj9qqLsyA0
 Wcq/JJeRAZ4p56gqsQCwuArT5WlzZsc=
X-Proofpoint-ORIG-GUID: tJL30nc30OMeF0M8hY2obQ1thkhexPa_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2NiBTYWx0ZWRfX+MYnS8mOPTUA
 onOTmq3w62nWIUYs9xe6Of0fHcaGb7hZ3nW8phl6mJhaVHgq7G3EO1sXBYTxaEKoI9k8MTU5wGV
 xhOC1ePVsq65sDEeaku4u/3K3w81nYcqxrk5DTF5NK7mAgchs1PyIdmL0CmyTVfaof8Lj6DQdIz
 F4u7vFHjXmw/h66Dh9FcAUZKAYL+w3z+2DNERNfH1HYfrjxsoDxcGwEZTdZU2LMAzSBSp045ClU
 FhQSfavAaaF3VHyRc9vKbWStk/1SSRaZVQPjeeHieh1ClALMwOYzAD1Ys5+RB+tjCKJm6YBIE3C
 bn7Sivscqti4m/CRO91mqyYWa5IdcYJKjo5uuOz2Z7lAmdybPDgh2KXlbMCWVJQ+G3LxYxrZuui
 HrmXBRw8u2l5CohGOtKKiN4G2bHb9j+b1WIvSIWC0pk5sDMGLa4i/WvBI4Arh/clOY+V8bpnMr7
 MVHWPy0IbfD4kHNj3ww==
X-Proofpoint-GUID: tJL30nc30OMeF0M8hY2obQ1thkhexPa_
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a34f3ab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LhlP-xRJkdPkIkh5soUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21021-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:ifranzki@linux.ibm.com,m:dengler@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dengler@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[dengler@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A6336A46C1

As part of the verification, the PKEY_VERIFYPROTK ioctl checks for
supported keytype, which are derived from the bit-size of the key. The
calculation for the bit-size of a protected key has to take into
account, that the length of the protected key blob also includes the
length of the wrapping key verification pattern (WKVP). Subtract the
length of the MKVP from the protected key length fixes this
calculation.

Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index d6b595eb3370..2160e1de3014 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -334,7 +334,8 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 	if (copy_from_user(&kvp, uvp, sizeof(kvp)))
 		return -EFAULT;
 
-	keytype = pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
+	keytype = pkey_aes_bitsize_to_keytype(8 * (kvp.protkey.len -
+						   AES_WK_VP_SIZE));
 	if (!keytype) {
 		PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
 			     __func__, kvp.protkey.len);
-- 
2.54.0


