Return-Path: <linux-s390+bounces-22037-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6pgFLD3ZUGrq6AIAu9opvQ
	(envelope-from <linux-s390+bounces-22037-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 13:36:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2CE73A4C2
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 13:36:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=fYrp5gHY;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22037-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22037-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0776301C3EE
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 11:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F43241C31D;
	Fri, 10 Jul 2026 11:28:16 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661154192E5
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682894; cv=none; b=YqsanED03sTRsjr84yiZtnCzrf04YP5aJzPyZRuL7arRYgMfN/zd+C1DeZyokoL1qswCm68lkZgCsCNUVWj0zqn640KTQDN0OvpWxfXrNkxGYRRzrD/cuGFYHCBba/1oVt+iahM+kWNo8Rqmg4OcTZPvMXyfuV2G5aKsSW6yCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682894; c=relaxed/simple;
	bh=JUQA/3hUS0G4GkXErsKOoteC2CcAkD1k0wQZ8ElSEww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+60GHQSFB8T4gNrNfJk+HFmvdXCLtkA+IeBsxOWFV7h5vV3Vk8hq0wDb7XX/TUdcB1+koRt+J1BCKu0dRxwuHBNb5cevOJDtwQL0GXLN2A8fTxECTOj78HKEP8eCe3V0Qc/9maBVuxdF4+vlWgtxq//hGgw+rwy0yUN8sZ9qL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fYrp5gHY; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAmbuc888642
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LB9IGQavZffui1A8rFQVOVbSHQ8bu7uO9uXE7JZBm
	l0=; b=fYrp5gHYpqIqTklyuf7XRx3/xcEtCbtLS1SChetDjowA3DCQmPRWB6k+b
	1aFVXHdm3sRlkyghWOd8EKf4cGUwv4xg9N9gQcx8AoXlNKSu1wym7+phiXyEAPUY
	lmyLbKzsjlm/DSafThHiV1PykeMLOlPh28d/vh5Hs7KT5XyX9VzIrFuAGg9Iifl0
	Ru9Q4fsaiv/OIyrw6aedYNGAzDAj6LoYVnSf1VpuclZ4jmVkCFJuf/ki88dcpOYJ
	9JnPVvuslXoMaom/R12G41xay1ZZbHqEFZW6Z8jwOBev9Si+Cn/DTSPk2Ig/tc2c
	glUX6SBrBE1E2HP9MF2sdzTp578kA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0bpat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ABJcXq000767
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hsmqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ABRvo662063034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 11:27:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B82C20043;
	Fri, 10 Jul 2026 11:27:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71BC820040;
	Fri, 10 Jul 2026 11:27:57 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 11:27:57 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v4 0/1] Improve zcrypt reply message verification checks
Date: Fri, 10 Jul 2026 13:27:55 +0200
Message-ID: <20260710112756.75346-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a50d742 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=sqYaSNMcq1rFRJ3UUS4A:9
X-Proofpoint-GUID: 7I7PoNA98JDdI8GJdrGrXdywNeei2eVo
X-Proofpoint-ORIG-GUID: 7I7PoNA98JDdI8GJdrGrXdywNeei2eVo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDExMiBTYWx0ZWRfX2eDpR54cGrTs
 04wn+ATlOlPxcE8HTryRY0L8ZGADR6UwpIY1R/YftJ91MgaBcXBt8ov4eAd1oqBwu/IeE4wBUtp
 VZ5ZV4YGMIrnSg7l6MhT0UUHO145oAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDExMiBTYWx0ZWRfX1P3j6ze4CVwO
 18A6gqmhAlw5LkUvXc/gxkwRcTstd5X+bX/PGEKpnDmhbkKQmzouzyVoORNn7rR4gKhtAT+hwFo
 plsehM4DSE3qaQlmgNRfBgLDa4xCtDh73CjQ3w2aMhzEL/fDaOSXL4P3jnZXI32/Uy+/mjhHNaw
 H561JW7wpa5B0v5dnvRiv87mJbpj+WCNAFQADky5939kGhRCnCMUoOZOT+9nPfrMMTydMpTv2qc
 XNV0GlLRCenLbXws7PqA6P4PcVeeTpTHO3UE2dtDLQZnqnAOq93ZoSN5aOs+zt6KqXSxZ0fMf8R
 HgqKioVOIjO+0NiyEFQnHTH8cuRANQHlKIs/g33JUXb+xPQpGDRRRudMqgZe6VnsWny9hOPW66p
 6qr3LqohN5pGZcC1TuMOHO8rAHyUvxTlne4vRDSFdfrDaxzr4u7Huuko5jrDavt4QdOpHXwKYZa
 uwIlTv8UuUMXOKSMxCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100112
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22037-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[freude@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:freude@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[freude@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D2CE73A4C2

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA and EP11 (AP message
type 6) messages. The verification code related to reply field length
was not designed well and thus firmware deficiencies could lead to
unexpected behavior in the zcrypt device driver. Thus improve the code
to more closely inspect especially length fields at message replies.

Changelog:
v1 - initial patch
v2 - fixed typo in header check_for_overflow -> check_add_overflow.
v3 - rephrased and smoothed subject and text of the patch. It is now
     "s390/zcrypt: Improve zcrypt reply message verification checks"
     and the text does not talk about malicious cards any more.
     Updated Reviewed-by tags
v4 - As sashiko clearly states the addition of two 32 bit values can
     mathematically never overflow a 64 bit value and thus the
     check_add_overflow() was total overkill - removed.

Harald Freudenberger (1):
  s390/zcrypt: Improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype6.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--
2.43.0


