Return-Path: <linux-s390+bounces-21235-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 38WEGP/pO2odfQgAu9opvQ
	(envelope-from <linux-s390+bounces-21235-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 16:30:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B56BF1FA
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 16:30:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=FBNTD8bU;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21235-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21235-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5A8E3012BC3
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ECA1F1534;
	Wed, 24 Jun 2026 14:30:21 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812B3C6611
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 14:30:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311421; cv=none; b=OceVxBf0FRTOizSFeRhHy7vDReQMfRtXqhKNGoswPN+7up5JNtp6Dp1wJlX6TvO8GSXdELXyxohKlbYcrnSuDNR+/gvnVSs+fgjBAmMCdvoqtXIvvNPb3oh7Nn41pBWmkx0Mm2y3vLdHCrKz8/ft1ZqxRZLYakUBOP4G60uMutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311421; c=relaxed/simple;
	bh=rOi3DrQihVElgX70ll/THauXYMPeDz/QWYZV7OSfqFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1vaZZieC4EIUzB3mdx1jCp5CyFXK0nEwzzoQmkFVqgaePWVUAbCQg3q4Zla5YXYl37808j/azdZ6y5F0fJdoG35PdOCErnUTrbHMeUb1PNbo9O1kffcpNhRLlQLpZEr1TeoPLQ2hRONF2dbTTP1ENiHQzMCDkS3jLrRtky04f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FBNTD8bU; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAnU1K597048;
	Wed, 24 Jun 2026 14:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pEznVU
	+QxB8+o1/ilzgZP2lZoODnRbI+ECyxYrTVnoI=; b=FBNTD8bUvV6UvwSBZQq+yW
	bzDpuH1jBuB+56w1jNMdX3mj74JX9aKY8fjvuQ6FqEqFigWNW53slgBCQ49EDAx+
	y1q+C1+wjOMVjuRpPJoJGTXvRkvJCb2t/F6hZ4NqxdAabqcpPXdWATAYPZN9gjVP
	N1nUjzjTPlaOgCUITxFw8QbZwDtTwP4JE+6VOO1+icyhks7eYzJjnJyiMG0cSQjs
	NRQJEuwuGUualOG4bJk88H9Seluak+6O47XOaoQwNjWp22X7MJ8UvAqSqBpz2KBg
	ZwE8DVOkqO5yGe/SAT8J44mZvnSyIAD6+VKHW6ol6k76Nxv71j0gbzEEW1/KChPg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hvsph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:30:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OEJf9d027341;
	Wed, 24 Jun 2026 14:30:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qh8v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:30:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OEU6tR47972784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 14:30:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A35D20040;
	Wed, 24 Jun 2026 14:30:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D71B32004B;
	Wed, 24 Jun 2026 14:30:05 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.104])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 14:30:05 +0000 (GMT)
Message-ID: <da195a4a-4951-465c-91d0-4e76fd2ce5a1@linux.ibm.com>
Date: Wed, 24 Jun 2026 16:30:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/18] target/s390x: Move cpacf sha512 code into a new
 file
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-4-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0ufHE_y3jTrsigLwX4OBnl0S8m1B6GYX
X-Proofpoint-GUID: 0ufHE_y3jTrsigLwX4OBnl0S8m1B6GYX
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3be9f3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=nytM24UiTcO3Y7UnWsIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfXxaDZDHqzVtWY
 qi30H/r8Pb9FHeFBIiQ1vIUpiuDA/dzgSl520bjVxNlnYRRl59pmmTCEa5sXKyWaJ61xIvkSTul
 aAWYa71s0xRTrSewU4/1orKvfk8s7vPSuatrO3zzvUUuTCW4Y31lQxHI2i0QkSjLF//vN9LQTGt
 aV/rlAIr5w8DaAojCEmIsJYLJgh3a9gaYvI3heYwVTIeUQkZambS7ZwNsSeMQNDc+XhpxzqWErI
 q6oKVIxp7Z/qhLpVOUevYPYuL+WlC7Jj/3o+zPaEi5qnbCN6IrkmK9TRlDdCBvaaA9vs68GTAzj
 G06uSsp9dEZDNNA/ix/5h+oXkFHVAxgKncvAGHi/1TK8n//g1Fk7Eoyeo86RtFVys0NeO5sli0Y
 kfXZRow7eSSLwaeRdsBQudDC9lP21g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX8bczneEq9t1A
 9k7YhYmdsLS4DyBmZzaB1RLqsSeY6r02SAZz6AyD6hDE0rxlx9GDP9uNyZ1ztvlh+PkYxH5S3jG
 Vi8iIYvYGdTU+9La29lt/yI+ilDubz8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240119
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21235-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux390-list@tuxmaker.boeblingen.de.ibm.com,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:fcallies@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[iii@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iii@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C04B56BF1FA



On 6/24/26 10:10, Harald Freudenberger wrote:
> Move the cpacf sha512 implementation into a new file
> cpacf_sha512.c. Add this new file to the build and add a
> new header file cpacf.h containing the prototypes for the
> s390 cpacf stuff.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf.h         |  19 +++
>   target/s390x/tcg/cpacf_sha512.c  | 245 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 227 +---------------------------
>   target/s390x/tcg/meson.build     |   1 +
>   4 files changed, 266 insertions(+), 226 deletions(-)
>   create mode 100644 target/s390x/tcg/cpacf.h
>   create mode 100644 target/s390x/tcg/cpacf_sha512.c

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

