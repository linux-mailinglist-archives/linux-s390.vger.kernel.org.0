Return-Path: <linux-s390+bounces-20586-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5NLQLmGKJmqqYQIAu9opvQ
	(envelope-from <linux-s390+bounces-20586-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 11:24:49 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C128265491A
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 11:24:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b="RtO/eVWo";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20586-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20586-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D151A304A9AB
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2026 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF783B42C2;
	Mon,  8 Jun 2026 09:14:51 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105331E83B
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 09:14:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910091; cv=none; b=uTX06wP1I5EcEVVIoVFGQfAUrIvjeaa2WWX1G4PapdgjlpJPMzJHm/BiLKKgm0uzFKeAZu2//0mUHW1Bi+OtrB9VG5xE+gIUMG+ycyThCdmL2FqdvUXlY6LlJLQ/vThHUrn0OMpCN5yBd+ucU4JroT98c25lzIlJFu+oIq3gdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910091; c=relaxed/simple;
	bh=Ir9IMakQVSIjygtXJSyrt2lvYxhqq0mTTjxuLXvyej0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeaZ5OHSopwl1Ymat30QNyJl1Vsl1+jCWn6Y2+Po+mSu5RqMCbiIGjete/mZIS8Vjt8IS+OzFpQrlNXiJdTOig1jjwMfTH/FWh9KikfQG8yZH4cS0MTapxldu7ovB0uwHugiW19b5HLGiNOwHUVSCZyB5KRv9qc7jdspKNMLy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RtO/eVWo; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Mtr1J3416909
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 09:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9IIUNaU+YAm6NymcdnypB6QKdKvatT
	dPTSY/9z/EVSU=; b=RtO/eVWoJ6wTtw3/6aMKKAQEsbuz6kLs+foUGXA6w8ozz6
	oejpyfXHSzOYBLfIKxS2ugua6+NI0Yc330WOhLOqaHt+/47/0GWH7TahoKCDYch0
	eo8mtte3py8K+Erfuxw/TmJugSsfU4q9S7yauBP9mN/E3ZVtts59TPFqLyI659P3
	NEQ3aZr46hkdJz5zAOWQbBV6ArjwNeyHlheSzF8wPNBrwcf+5MN6KskcRniM0MXD
	CM03FeqOrPzsrQxvDE62u+p63Cf7ZEYd/SJU3O74pBK9945m4PxZsX0473zyp/cv
	wbCE84YFazYLujmb6LyVCDMrVfqW/Jhcy3DhL//g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qegp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 09:14:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65894cZV028623
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 09:14:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vvr5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 09:14:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6589EiVe52036084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 09:14:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8735920043;
	Mon,  8 Jun 2026 09:14:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2184220040;
	Mon,  8 Jun 2026 09:14:44 +0000 (GMT)
Received: from osiris (unknown [9.111.82.157])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 09:14:44 +0000 (GMT)
Date: Mon, 8 Jun 2026 11:14:42 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Juergen Christ <jchrist@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 3/8] s390/string: Convert memmove() to C
Message-ID: <20260608091442.34400Ce7-hca@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
 <20260608053754.571282-4-hca@linux.ibm.com>
 <3408b4d5-7542-417f-9da6-67e212071d97-jchrist@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3408b4d5-7542-417f-9da6-67e212071d97-jchrist@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a268809 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=mDV3o1hIAAAA:8
 a=3pf4lNjAOKGWOX1D7Y4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 0vcIFTEi0jC5K9dOCxPq7npxBmFUuVNh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX4Hn4KqB9JIcl
 ctLJTNpnZw+qSouVVOdftzXy+8BueVr/JMwUrUFn4d2Lopj1t550aOMZU1wurrnGRzatFPbs5RZ
 G9ze9Sfn1fe/Nul3C/ixJyyBJ2AiDZHl+FP7uKPz1g70NzXbMI1mXaelx3aa6IxGUP0930BDpG1
 MjgXWZlHZvX8W9nhjgDwkBXfqW2YtdGUJpBTB9KgIBQ5ZOnnu1DXAgEOVjRlfTEax3YuEonKTYk
 SE737PWCUV+z2TWfwog/OQxOpTu7nkNyssrpZ0U216iwWdA2U5JLwDL5AhNOBbBOSl/G0l9fJG1
 4WAviSuKliEqhSXbNkWbgXL0WPONBGGpp80p2y3lsaxZaIvvK26O83gwWPgZ1+a31+J8koVSbnR
 cWJGBLoWsTZ5Bm56cFxE65bBqXUG0pYJo/surJRV3pNZ3oc/AxrD+vNmResQ3jKKpEP/pHhV//g
 eJStmJo0uURaZHtfcBA==
X-Proofpoint-ORIG-GUID: 0vcIFTEi0jC5K9dOCxPq7npxBmFUuVNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20586-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jchrist@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:from_mime,linux.ibm.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gnu.org:url];
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
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C128265491A

> > +	if (!n)
> > +		return dest;
> > +	if ((d <= s || d >= s + n)) {
> 
> While this might work on current compilers, technically it is UB.
> Pointer comparisons are only defined if pointers "point to the same
> object".  To be on the safe side, you would have to do the unsigned
> long dance around this C standard definition.

There is a GNU C extension, which says the above code is valid:
https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Pointer-Comparison.html

Since GNU C is relevant for the kernel, I'll leave it as is, unless
I'm completely wrong :)

> > +		while (n >= 256) {
> > +			asm volatile(
> > +				"	mvc	0(256,%[d]),0(%[s])\n"
> > +				:
> > +				: [d] "a" (d), [s] "a" (s)
> > +				: "memory");
> > +			d += 256;
> > +			s += 256;
> > +			n -= 256;
> > +		}
> 
> I am wondering here if it is worth also doing a 16 byte loop and,
> maybe, a single 8 byte move.

I'll give it a try at a later point in time. For now this is just
converting the existing code. Thanks for giving the hint, and looking
at the code!

