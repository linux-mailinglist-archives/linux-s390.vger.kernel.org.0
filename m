Return-Path: <linux-s390+bounces-21872-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tehxOt06T2oIcgIAu9opvQ
	(envelope-from <linux-s390+bounces-21872-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 08:08:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2272CFB7
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 08:08:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=qM7UYGp9;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21872-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21872-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0548300EE90
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2026 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E1337206E;
	Thu,  9 Jul 2026 06:08:28 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BA1FC8
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 06:08:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577308; cv=none; b=C+5HpJLcEOy33S7GCgQoa4X7zFr2WvG6ok2/pW3gfaTpAhjkgGbsm048Ub7N6yF3G3AxnknC3aL7S7Y9JE7tJZ3t8ml986qEJdwgZDVX+2o/cUr4wqYMhoC+s9m8RzqBLAk8T2ePRsDE0nMJXexUIL6v7Nmi3IbUfbBFHC+v+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577308; c=relaxed/simple;
	bh=9ktLk0zyaNOKQwyWiCZm/+RMSviFfC9OXGmn2uap214=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNB7/Ba/oFJGkmq5hwAEEXHZJ02SE+64c8K9IoHjzZtif6bBcgjojHUUyDGisi+P6rIxJ6uNay3iSlfyX+TNn95ZWPqg0lNqv+cv6p7UafS+6+pukLrhkedwCx3oq7mR27Hfn9TU6ezVOLqKD5375dhRMMSIWPxHTZj952iz2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qM7UYGp9; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668NIqun3801382
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 06:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JzEedTGR4U7PlKezEwE0/TZkfyq7LH
	L5UNkh4mJUVeM=; b=qM7UYGp9U6yuUBHMt5vqSbpO7oieqe8PCl+upay//jpVgS
	Cr0Bqwy6n64uFVhDJ+87XRATgELS+N5j8MXK8BjyLK2NtgmGa2Ale7cbWpmpRH8m
	VyexbZy3CoQoCC7m+JSGVdyaVP0vJRDq+c5J1BsOZJjG2LhZiIWszzfKsMZpOtOg
	uCT/EE+pDcLJZXBkUliBw3yEzQBgBpRbIGaJBMAK+qrttPOvnni6Wyds1PPUiVLC
	/IMJp9EErGIUQ0PrJQCPdXS2FlQkMgR3yWDMq0Kzx0+4Rd5fB+LGHyh/Fo2Kp7lw
	69i7xUO6zeFG5ztlUfrmVFEp8O9j5+ONSULRNY0A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt0jmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 06:08:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6696525s028519
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 06:08:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqc1sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 06:08:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66968JUf16843138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 06:08:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57692004B;
	Thu,  9 Jul 2026 06:08:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75CBC20040;
	Thu,  9 Jul 2026 06:08:19 +0000 (GMT)
Received: from osiris (unknown [9.111.65.145])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 06:08:19 +0000 (GMT)
Date: Thu, 9 Jul 2026 08:08:18 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/checksum: Fix csum_partial() without vector facility
Message-ID: <20260709060818.25563B9c-hca@linux.ibm.com>
References: <p01.g0de361f35d11.tthup4z@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p01.g0de361f35d11.tthup4z@ub.hpns>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gaq8u8C985sLZVOZC0rOotlgYzYMKLLH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfXwuLoa5Je/ZgU
 3CE/cN8olRwHRE+jiYK/xaSAjItWaOn4AQjTpNR9MHc4TIiQsiTJZ0t2UnB2oOHtQUgtMKAFQLd
 TkFFNKsRJwdTlMRP2GP7+KqnXEW8f5M=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4f3ad9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=C1qSkgkhWnosBV7ZQaYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Gaq8u8C985sLZVOZC0rOotlgYzYMKLLH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfX1RqQ+UO0nIgd
 q/tqAi9PWdrI2fgZDms+8i35DTkq+PNISvy0w87oAXye20oibyC8dPTWcH3q/6LTtJfgRlOlENt
 9louZI1E18Gtos0I3bvRMckzsYN3dh0j9GWMVOrab1fN6spU2tcuoPgE3Yarg+D5VeIaBXOSMgY
 nXoU2p8feEUpylpJqUUnf/ASXaqr8XJci11nhKxzmbRwKHEs58uNkXsjGGYM0wqpCBShI01kftq
 Yf9HbAA+Sa1O1QRaaQdB37ktTNbLfzb5vbcggbvpYZLRDSzWq8c/VTYvdVYyT7FzxXcRGAlobNW
 6aoTndJqpwX9zO4JorcWxxQEX2gzlAvYz0nbYqv3hjTDhh6dFeeQdbzV+5PKsaxonHAaczy9Cxt
 W/XN+uOaJlWfPEir3YOVK8yPmgal8khKhMnicaIZGTCVZ8xPXR6uUZUeE8BcJqfQMmhOzfs/Q8I
 vTh/LCAUnPYGc7Is9Tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090052
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21872-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gor@linux.ibm.com,m:iii@linux.ibm.com,m:borntraeger@de.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
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
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88D2272CFB7

On Wed, Jul 08, 2026 at 12:02:14PM +0200, Vasily Gorbik wrote:
> Currently csum_partial() calls csum_copy() with copy=false and dst=NULL.
> On machines without the vector facility, csum_copy() falls back to
> cksm(dst, ...), causing the checksum to be calculated from address zero
> instead of the source buffer.
> 
> The VX implementation already checksums data loaded from src. Make the
> fallback do the same by passing src to cksm().
> 
> Fixes: dcd3e1de9d17 ("s390/checksum: provide csum_partial_copy_nocheck()")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/lib/csum-partial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/lib/csum-partial.c b/arch/s390/lib/csum-partial.c
> index 458abd9bac70..9d74ceff136c 100644
> --- a/arch/s390/lib/csum-partial.c
> +++ b/arch/s390/lib/csum-partial.c
> @@ -23,7 +23,7 @@ static __always_inline __wsum csum_copy(void *dst, const void *src, int len, __w
>  	if (!cpu_has_vx()) {
>  		if (copy)
>  			memcpy(dst, src, len);
> -		return cksm(dst, len, sum);
> +		return cksm(src, len, sum);

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

But at least that also tells us that this code never worked on pre z13.

