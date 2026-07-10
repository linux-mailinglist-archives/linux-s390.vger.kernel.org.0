Return-Path: <linux-s390+bounces-22019-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EYhqDHWwUGr73QIAu9opvQ
	(envelope-from <linux-s390+bounces-22019-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 10:42:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7165B73898D
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 10:42:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=tbpTwHWe;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22019-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22019-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93DCC3050E7F
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789713F1AC0;
	Fri, 10 Jul 2026 08:40:51 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125AE3F12E1
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 08:40:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672851; cv=none; b=SMw3eaBT8BiWoJubePKfEgTPmykzmZjPAtOt7SBfFb5OtzoVyh9OxfzDSO6kZecMC4BPq4xSxJoObALeUswhlMfrfQGkYFU5L1J1o9UwQalVGwyjwfGkIuAnnivNddliflOazhVGJzraEvFj9k4UpjN+nQ9waefos89y/hZIsf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672851; c=relaxed/simple;
	bh=YxLkxaLKGPbQUPWOjtTCzo+sY69ap72Lc9BqmuvY/Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4FMkthNlDjGuJXRJXrijXryX5IQ68DEjlmcFBoF6G1zPAJbtGdMW0dEfx2eCyoZZYLoRn7mlO5e1pZdm8kxdfED+b34tJZrmR49K/d9Uo48B0uBShBqc6HcUNfOleLio9zS4hrHCDIFLXRphENLJLYMTeeCt1jusYed53/DerE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tbpTwHWe; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7nRtT607204
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 08:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ukZaGD1K+vhcPGs0h7sre9WLAWTnzh
	7LB2m5u3DOyKk=; b=tbpTwHWeE1rrnO+dcHkxqQhth7q+IFM84yt1DIs5RwG4qI
	G+htiV0eLxCEsk26hGCoh5YOIXNjptceh5khSqLv+/tTIG5wJGPt8iTw+vQGEVrB
	N9IngT9eNfLOqg6ijDBNVmtzjtctZA9yky7F+X0cBDwguQcans/5/TwFsoy1W7CO
	/QOV4HlSEZuwOUbgjxn3Ns4/dsC9OEwecgG03RUDAAzaygdWNnYgRsjvPcAHiFsZ
	CHU0pVYI0Ou8vZ4Vbcgfb2lsUUoQZojEDvBPoI5ucCh+oW1xbMb566RIOAMrOgzO
	u6ZtRmn9LV96wB0+eG/BvovkPXY+2KI3V25RpUbg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknw5m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 08:40:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A8YhKv015371
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 08:40:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkh5ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 08:40:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A8eivn60686724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 08:40:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 141D920043;
	Fri, 10 Jul 2026 08:40:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD35C2004B;
	Fri, 10 Jul 2026 08:40:43 +0000 (GMT)
Received: from localhost (unknown [9.111.0.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 08:40:43 +0000 (GMT)
Date: Fri, 10 Jul 2026 10:40:42 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390: Remove PIF_GUEST_FAULT and add PER trap flag
Message-ID: <tthyaru@ub.hpns>
References: <20260709195500.1241833-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709195500.1241833-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a50b010 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=TUaCbrCJA9lGdIzC_NEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ith5psA_xnEUQoF-WeDvvreW2LI937GG
X-Proofpoint-ORIG-GUID: ith5psA_xnEUQoF-WeDvvreW2LI937GG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MCBTYWx0ZWRfXzc3FUth0mrqF
 HsLzVSVGALbQTXpwxzU60iu1wvet8qPRTSV/Wu1k1KxfocxhhuOs5MJBk/bS5VJa8NzxIPQv6ad
 qF8I2p68Jg0OSytYN7hyVUnRPrk5v1w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MCBTYWx0ZWRfX2jWrebSQuUMe
 D2qNSgX6z5KnsY1cvgAgUGDFczHfhG+/ta6Vg6GWVS3cD14VGmF5ipzmJy3bTQLFQumaLf3bNyt
 GGveGFH7PQIdIha/1OQvZq00dmgbIu3i2cX1u631YjwTzg2CFWeU5Z+2ej+ujyMU7fBRoHtD6Jd
 8K8hWpe7fg6Swjmr1AOYyaCmGu2Vwyp8T31fFYq6ABpY3tJkRBIODPp7OGDHaSl4vCuRvJ6e7Ox
 /lpZmUX4fYqT3KEf+p5nRFz5GnxvYLT0xGoqVKatHKo6FnZVviA9/mZmkWp/NNLA1s4OOdtYJqE
 hRg23RrA2neQt1Mi3X8JyGY5vuThJTkeUs2y6RZI/AZAALxgQMJ3BDHG1PsgZL20GuVOu5X8a4j
 /bJkuQC+IhpamwWU0/6zSVx4VekCqJ85dI5VUANwfLv1xndgxFB1QmHJl8YPvcgLPh/mtw2wPx5
 HS5KQEHZZRuP3EHIC6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100080
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
	TAGGED_FROM(0.00)[bounces-22019-lists,linux-s390=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[gor@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:svens@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gor@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7165B73898D

On Thu, Jul 09, 2026 at 09:54:58PM +0200, Sven Schnelle wrote:
> While looking at the syscall code I noticed that entry.S still sets
> PIF_GUEST_FAULT in ptregs even though it's only used in __do_pgm_check().
> Remove that and pass it directly to __do_pgm_check(). Heiko suggested
> to also add a define for the per trap flag in system_call().
> 
> Sven Schnelle (2):
>   s390/traps: Remove PIF_GUEST_FAULT
>   s390/syscalls: Use define instead of '1' to indicate PER trap
> 
>  arch/s390/include/asm/ptrace.h |  4 +---
>  arch/s390/kernel/entry.S       |  9 +++++----
>  arch/s390/kernel/entry.h       | 10 ++++++++--
>  arch/s390/kernel/syscall.c     |  4 ++--
>  arch/s390/kernel/traps.c       |  4 ++--
>  5 files changed, 18 insertions(+), 13 deletions(-)

Applied, thank you!

