Return-Path: <linux-s390+bounces-21026-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7biLNfv4NGo1lgYAu9opvQ
	(envelope-from <linux-s390+bounces-21026-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 10:08:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3230E6A4846
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 10:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b="M4a8KQ/d";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21026-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21026-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E20030421C5
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174323590A9;
	Fri, 19 Jun 2026 08:06:03 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C635C1B0;
	Fri, 19 Jun 2026 08:06:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856363; cv=none; b=coBUmClOELvUrGTAvN318Ka9y8CV2ljPbydVEYc8q2fCMP114zfLIHcDfQo4TnrcGb1jA/MZm7kDyubPcC9hoskubgZJP90ol+8S21AFWT0mfK7LA+rMp0FT7ToE20g+KWXPhBKkKMBxVsTnXikgDsIgv4wyX3vdku+dOvt0Q/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856363; c=relaxed/simple;
	bh=S2iFiMF3ajk88PBzCHYJ99rKaZMLg4ZjbumU6661QZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNEPxnMS1mP9HS44qFSA/6+LETfH40EwSraZXN4KrBoAWH1IdaYio8wUBdheOhvoCamOVgJFEAAxfo/MImWFsDKbnTOz5WlH8nQPH9I8iqsU0kn+SHFArZTQabq6UhMjFwm9DfareT2DbuGqoVAkFtjjQNieRBLGggGIiNDglCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M4a8KQ/d; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mLHb1711909;
	Fri, 19 Jun 2026 08:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MZXVunEtN9ThDmgojov6Qide8Bvygb
	PrmqNZnMFgCTU=; b=M4a8KQ/dMhW2sGmOoxPlwcqzBb6OYiWoxB7GdOrhmnfmxt
	2gGzvlQUCnbuNdMZvxhvh51x/Ls9lB0DK1kxDN5P/q2ze1ZI61IhwxhUir4Pr/PF
	Ke8IzxsAwzhjMoPVBOQIcKI1jiCDh2I7kjkjjC8oryrx7ieJPJmbg3IZq/bfXLs7
	f7TTd2Azl6O8ttv0ovcxkVVf7zE2/su3IIHMrSyWEcfdjuNyuN3meeYwa4wvDzSY
	q7TYPey0OP+l9wNTQEWp+rHbZA+7S7kAw3zYNZsnCNNHi6c2svHJzAMNqkeft/Lh
	So4QsfmAigB8fWu8PC/89fbkxUU0hfVNAazNQ0qg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtvh6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 08:05:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J7nqdO032171;
	Fri, 19 Jun 2026 08:05:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172fuj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 08:05:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J85s8o21954982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 08:05:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A2302004D;
	Fri, 19 Jun 2026 08:05:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C43332004B;
	Fri, 19 Jun 2026 08:05:53 +0000 (GMT)
Received: from osiris (unknown [9.111.29.105])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 08:05:53 +0000 (GMT)
Date: Fri, 19 Jun 2026 10:05:52 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH v3 1/4] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Message-ID: <20260619080552.18590C8b-hca@linux.ibm.com>
References: <20260616165110.360921-1-imbrenda@linux.ibm.com>
 <20260616165110.360921-2-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616165110.360921-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zdoAPCc6cWxMjxZQoN5dvhwQdxlsji7P
X-Proofpoint-GUID: zdoAPCc6cWxMjxZQoN5dvhwQdxlsji7P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA3MSBTYWx0ZWRfXwRm5U3Slt9/V
 MwwBTTz0IQkMVO1KFnlknc2RSgDlfCF9l1ePpRfOIIH1FDy0qbvBynPYAnfjITbCjcGEwqhEY/G
 u8+BXRFvW+S7wLWCDLUJERpaRVoAxBfRjqWty3lv7SWkRWgOnA4tBFRTki5zSWF++UI3V/vLU5e
 J/nyp0VOEdfXx1vnwngFU46l7ONuEOu1L9iwhakLUhBgR8X1djKq4qkL5JbKgdWdbYHweCgZ7PI
 euiHQLNmiWQBiqMskyOKHCi4jC+Ib3n1Eekssn2ed1vm53Z7lvwxA0VN4ZVraypfOgNmFJZQQ42
 C9hIlYVY9vFH+ucIMHraWeWIkjr+p/CF1up3ZRe8AddDiwV7xIyUzSrKvZ2vcLOmA4l22kmDgbD
 yiESQDeuQ23rOV8DxyT95ggm3Dk+RokJnv7YUhyQiHojDRvFHvBEwUoua+JhEp7xyUmNfIFaF43
 uXWYF93nVDAIJk0+o1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA3MSBTYWx0ZWRfXzCDIyBp5C+nV
 5RCUBckYUrvlH1I5nDx5nqZttQCRunHWvXjK8/SuPeLJAkVj2N5nfDwSXyE80MRA9mF3zYQxnO2
 XmdSIhoBaQi83YvyCPTcW0TB4ggdbnU=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a34f867 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=08ievGdDU2XUJ3-m9ZIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21026-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3230E6A4846

On Tue, Jun 16, 2026 at 06:51:07PM +0200, Claudio Imbrenda wrote:
> The _PAGE_UNUSED softbit should not really be lying around. Its sole
> purpose is to signal to try_to_unmap_one() and try_to_migrate_one()
> that the page can be discarded instead of being moved / swapped.
> 
> KVM has no way to know why a page is being unmapped, so it sets the bit
> on userspace ptes corresponding to unused guest pages every time they
> get unmapped. KVM has no reasonable way to clear the bit once the page
> is in use again.
> 
> Without appropriate cleanup, the _PAGE_UNUSED bit will linger around
> and cause guest corruption when a used page is instead thrown out.
> 
> While set_ptes() checks and clears the bit, other paths that set new
> ptes did not. This led to used pages being thrown out as if they were
> unused, causing guest corruption.
> 
> This patch fixes the issue by clearing the _PAGE_UNUSED bit in
> set_pte(), so whenever a present pte is getting set. The check in
> set_ptes() is then redundant and can be removed.
> 
> Also fix gmap_helper_try_set_pte_unused() to only set the bit if the
> pte is present; the _PAGE_UNUSED bit is only defined for present ptes
> and thus should not be set for non-present ptes.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: c98175b7917f ("KVM: s390: Add gmap_helper_set_unused()")
> ---
>  arch/s390/include/asm/pgtable.h | 4 ++--
>  arch/s390/mm/gmap_helpers.c     | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

