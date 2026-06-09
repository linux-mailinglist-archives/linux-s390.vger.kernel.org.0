Return-Path: <linux-s390+bounces-20659-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hrU1KgoHKGpJ7gIAu9opvQ
	(envelope-from <linux-s390+bounces-20659-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 14:28:58 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 200646600EF
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 14:28:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=OXpLuKr0;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20659-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20659-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8370A3069C06
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FFA3F1ABF;
	Tue,  9 Jun 2026 12:23:33 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334F413628
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 12:23:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007813; cv=none; b=UuVG2ydUv1yj0s0JlLbJ/KXYBKdxb9cj40tQw1SOR6mbys4zlmcEoM+zHoAE9Q4y/gnAaQrU3mGth7Y1a4raPAJ74U2K1su3s6uoXDEh3NQLx/KPVslaNa3C5hLq50gMnAukrOwZt5Q4KJC/8QIAVDHjalVH1EWdyT6BcNEOcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007813; c=relaxed/simple;
	bh=FIjwkdvOdKckGGO1tSY66F4rJT+SV0OSqeGeFAqqDmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCrsNbLmx/N75jA/Lf4PpNmyGk9e/uTt+ji8sgASB+WIO1xCJMIIbQ0rw5N1jdNCEAUYFGUsXT7WjT3km88E6f2O9YO72bVikrl9VDxEo4Ay9Ewd9NQoRLzypEjmBa8J+HR81KaevCiTDnyvs3TtvDiQ6J2w6AomqzNBVn/zEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OXpLuKr0; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659BKWDA2552576
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 12:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4eR+j9cYbAezlpqG3tJFq9q/JuvbW1
	+HES2f1RQTKXA=; b=OXpLuKr0wqkkviWc9BAuynzOwNkCA7en84QrxLeqQitIeI
	RGr8Key2S89myxeOkK5fwwnGld/JtSYpY6zX3r76jh9gmt2gmOo66Klx+nfioG+d
	UBqv9O+SU5GapTrRD4+fI5aZh+HdODvEWtflJW9o9I0dWP7uV16kCX5j3ynBDQPW
	pYO9tYFkA40lClpblyqXYB+8NdbeAl6gGRDMR6waRDWfrlf6L2pan2odamlNueJw
	0+G+rtGVokiB9xqYQFxjDkfxxA7u325Dj0hG4S/a1v10eWivkYNZDpP34rWW9upT
	Xtk3JFO64lKmmZbE6B+JxyeAEVKa4UlDIiVC5jJQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhv258-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 12:23:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659CJaEA030577
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 12:23:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy9mtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 12:23:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659CNPor27460062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 12:23:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB36820043;
	Tue,  9 Jun 2026 12:23:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD0C820040;
	Tue,  9 Jun 2026 12:23:24 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.224.76.97])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 12:23:24 +0000 (GMT)
Date: Tue, 9 Jun 2026 14:23:23 +0200
From: Juergen Christ <jchrist@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 3/9] s390/string: Add -ffreestanding compile option to
 string.o
Message-ID: <76d82e3f-429d-46d8-bfad-e7ac0a974296-jchrist@linux.ibm.com>
References: <20260609103343.107325-1-hca@linux.ibm.com>
 <20260609103343.107325-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609103343.107325-4-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExNCBTYWx0ZWRfX++Oy3AG1LYsB
 lQmz01R8gHQHXi48FWcrwGE7EBIqNKFQWR1U7tbKRNNY+HitRUK/bCPeft/V05FOdm81vke6NJ8
 zoFqOlqWz+1vVM97ztfDJxQCjCDzQ5NRvTnVlalNfqvyFVJpV2VeRTCo4RwS5ZDsXXVZ4j2zMGk
 doBXR86yb7Xsgl3LnXH3RB0gEvK2eLF0t0b2Mkemqr+D0s7F7DCgdGK3OEzb//poYaZLNm8+99w
 A0aDspAMxIs5jIElRXPWCHzQUbYBnBzvL93TqealH5ZGeEpuMrDGlKRdi8BRHE5Xz+yrvJ7gmJV
 GARUQFvBnPnuXrK3q+VYdu7a8zKsjB/stkLSGMNvpFBLRby9XybTeh0TmSB5v4U6G/TIb1z9b+K
 MMWpI49rggkO9oIA/uxLJy5H//HtFH7gc2+X9Rd26fEqPm4ikpHXOpyaoqkzhOeEYOqwRlmftFW
 u08PhWUR3hsecV5Y+vw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a2805c1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=3p5qBO8qKXI-6SHdRmIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: DuJUGf5rKZpoS2W8OapF2GnKIzT-XjnV
X-Proofpoint-GUID: DuJUGf5rKZpoS2W8OapF2GnKIzT-XjnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090114
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20659-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jchrist@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jchrist@linux.ibm.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 200646600EF

> Use -ffreestanding for string.o to avoid that the compiler generates
> calls into themselves for standard library functions like memset().
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/boot/Makefile | 5 +++++
>  arch/s390/lib/Makefile  | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index a1e719a79d38..e1f82d118bc9 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -25,6 +25,11 @@ KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
>  
>  CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
>  
> +# string.o implements standard library functions like memset/memcpy etc.
> +# Use -ffreestanding to ensure that the compiler does not try to "optimize"
> +# them into calls to themselves.
> +CFLAGS_string.o = -ffreestanding
> +

Other places use simply expanded variables instead of recursively
expanded variables for CFLAGS or LDFLAGS.  Is this an issue here?

Otherwise, -ffreestanding turns on -fno-builtin which then turns off
-ftree-loop-distribute-patterns which would detect the
memset/memcpy/memmove loops in GCC.  So that is one way to make sure
this does not happen.

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>

