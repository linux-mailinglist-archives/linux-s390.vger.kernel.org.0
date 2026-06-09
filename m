Return-Path: <linux-s390+bounces-20651-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QJfjBNfwJ2r85wIAu9opvQ
	(envelope-from <linux-s390+bounces-20651-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 12:54:15 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45A65F292
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 12:54:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=bxXVcaqS;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20651-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20651-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D8D0305A1D7
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA563F483E;
	Tue,  9 Jun 2026 10:40:27 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC63CEBA6;
	Tue,  9 Jun 2026 10:40:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001627; cv=none; b=AFrZDOaZdLBxPaF00TEHBI4N6ILMWwHVFxgX9ssQ/osDmCHujm7wpdc9A/Tw61/DqwFZyTrR8o42hAgKLPGDvh0FTv3bwhrE0t5P7G/SYM4D31Zcy4c9Eo3Zj3WlqFsmvcO/pVhbYJELWQV1skznMT8a6IpsRmSSt/PjtdDV6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001627; c=relaxed/simple;
	bh=5Eyy0XQVDB1OVyi6Y4xxDRHxkWSl9LGNNOegcRZMpSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4VmM/ENCf8Clw9i+bTPHvtdbdZ+1KG3YERnr+STuLKnSUG8NkSV9Dhs8sYqToPXSFbDNxmCJW+nPsh+BP4KuyOHd3kApBRZFpEqvlMXp7IfcX3rEi6disS+EMnVg1/Z4UAf3bzAj0IzV/fcS/J8R/jOLOjgTbPUGyvTG2cpOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bxXVcaqS; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6594FbvI3480113;
	Tue, 9 Jun 2026 10:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0WSttR7xuTezxWtBt0r/2p/NHeY8+U
	ssiVjWhIFfUn8=; b=bxXVcaqSUZ3+HYwPkoD+99lmDXouph8/FA6YifL9fHAFCA
	ube/VjNGcDlCFCSHIXPdOBEhRDigxZ+MoRBoD6o0rB1vf/jExhmWr5gExpst1BlI
	Z2K+ZS4ZPMI6FkEi2erRJ2vX1/pLxp8MPD4UVTf90KSoOT7NjRk20KhIUOUrEiYX
	Gfh2yeVlRdoENMU0PdcgDSTt9EI7Frik3ifzUU/pJxwWC8i8hxhmLrcHU5KTqnnE
	O3nnWVOS2W9iHQNPcB/dB3/cpbNrMQhwL8RlXbSoM32IEjE5CWLlegibHRK1WOED
	phO6CtSu3lqZ+8Pxnx0nXq+MdPqoHU5oSTpc3rJw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sudc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 10:40:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AYa47018689;
	Tue, 9 Jun 2026 10:40:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g1chw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 10:40:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AeDoX27263232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:40:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 636F52004B;
	Tue,  9 Jun 2026 10:40:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D390E20043;
	Tue,  9 Jun 2026 10:40:12 +0000 (GMT)
Received: from osiris (unknown [9.111.52.116])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 10:40:12 +0000 (GMT)
Date: Tue, 9 Jun 2026 12:40:11 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] s390/idle: Introduce cpuidle for s390
Message-ID: <20260609104011.9217Bd8-hca@linux.ibm.com>
References: <20260609075213.31094-1-meted@linux.ibm.com>
 <20260609075213.31094-5-meted@linux.ibm.com>
 <5d9a3d2e-f083-49d4-a311-7801e70ac1a2@arm.com>
 <77a82533-2f1c-4bf2-925d-f48accf45951@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a82533-2f1c-4bf2-925d-f48accf45951@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eyezJkOJBpYFAYBMCUO1Gr-k7J714q-Z
X-Proofpoint-GUID: eyezJkOJBpYFAYBMCUO1Gr-k7J714q-Z
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a27ed91 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=PQv_8JjY_DnSjf3yQIUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5OSBTYWx0ZWRfX4M7hveJgA9G+
 wARkTU9G9R7nH63rAg3jhZKQi1/nM0qIf5SbzowApHGhRbEoSl7AVFnClAwzq89TTrbC/gUbJsJ
 AD/L1D6kQ+qlXStWM+n0Z4SvSxySWlnZmbU2IBiOiG/LHPvVnNHflO4wIeKXx0e5Qk59W6mmEyi
 NZ0bF764PFZjalrItmyqLbaK+30zVxlbCemZqTKl0vS6TLUG000Taj2AeS2J0QHDXHYMwuqHHex
 H5dtAituUJPOAKcU5g8QArPwm82mIMLoEldi2pjPW6L/PT1oRxg+NVor1vv4JM0HlDMM3PlbYHP
 Boz5O7p1k8YsF+Slzba3nhsXZgnrRHjkwetrTV3jJTRH0bM3+43cKd9fPHS0mWGw0EKUgy/i4Lo
 y9KmvsG9ZY3U793fXsHh6kF+wN41W9+EOVoYxjb799AHEJv5RbD1ENL1V/npv8AXITzMwgl0PQ7
 K5i6neFVNXvK/0FSoSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20651-lists,linux-s390=lfdr.de];
	TO_DN_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:meted@linux.ibm.com,m:christian.loehle@arm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:tglx@kernel.org,m:iii@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D45A65F292

On Tue, Jun 09, 2026 at 11:31:22AM +0200, Mete Durlu wrote:
> On 6/9/26 10:12, Christian Loehle wrote:
> > On 6/9/26 08:52, Mete Durlu wrote:
> > > Introduce generic cpuidle driver on s390. Use a two stage approach to
> > > handle idle scenarios and use TEO governor for idle stage selection.
> > > Two stages are, from shallow to deep, idle polling and enabled wait.
> > > 
> > > Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > > Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> > > Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> > > ---
> > >   arch/s390/Kconfig              |   5 ++
> > >   drivers/cpuidle/Kconfig        |   5 ++
> > >   drivers/cpuidle/Kconfig.s390   |  12 ++++
> > >   drivers/cpuidle/Makefile       |   4 ++
> > >   drivers/cpuidle/cpuidle-s390.c | 104 +++++++++++++++++++++++++++++++++
> > >   5 files changed, 130 insertions(+)
> > >   create mode 100644 drivers/cpuidle/Kconfig.s390
> > >   create mode 100644 drivers/cpuidle/cpuidle-s390.c
> > 
> > Since this will be hard for anybody without the hardware to maintain,
> > would you maintain it? Or the existing s390 maintainers?
> > If either then please also modify MAINTAINERS to reflect that.
> 
> 
> Yes, I'll be maintaining the driver. I am not sure if it should be part
> of the patch series but I'll add a new entry like below;

It should be part of this series. Please merge your provided diff into
this patch, and resend the whole series.

