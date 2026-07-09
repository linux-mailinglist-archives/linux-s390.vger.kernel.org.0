Return-Path: <linux-s390+bounces-21922-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MdNdONF7T2qahwIAu9opvQ
	(envelope-from <linux-s390+bounces-21922-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 12:45:37 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7445772FCF8
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 12:45:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=kBba0Os+;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21922-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21922-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F19E2301CD06
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2026 10:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6F93A381C;
	Thu,  9 Jul 2026 10:43:01 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C33D969E;
	Thu,  9 Jul 2026 10:42:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593781; cv=none; b=DGKNT1yYGlGWUH7K3jyJFt1W02y24cBIwbTytUqFOj54DjeG3eA7KsggymRIbdryCvPhdnv2sIppCVn+CTGgG8DoQdQsWhJPgcD7WT/M/XpUfIpUGTY/0P10qrnZznwfaVKYkg33YBe//pd+elD7NjrFUL65ecnnaMT16IssDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593781; c=relaxed/simple;
	bh=5J+134eb2t6nGCA791k4kRjVtfTgbZPinCClOq4vl2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJjKOGLrBR45ixmtkwhIBxiQJBq41Up9Cnr3LkEMcio3p/vEDX/7CCb0VuN48A/EJFKq0f9itXvsDn3xJyyiUa39h0JEdNfiaZ1liUAL7MyCLvbieDfBZZRzD8+yMOqT0nqr+JUrpe2s6rd18nOgc+/VQ7F4htHpId6IFMit5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kBba0Os+; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696INgZ1154744;
	Thu, 9 Jul 2026 10:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bJoHloQObio8/qxAX4AxkI6czcw5Vj
	8i2a2wOSd5VBI=; b=kBba0Os+VbStaBM6mW4XsOZirrcPYdNUgsrcYULHdmwgn3
	Ny6fLIm8cPJqIRFYBU/if4DsfkyG528krpZarhym2Qs2gO68lkBk3KsodE3KA7MJ
	3WVLIHAPWLEsZn/iJr/vuJYvtUQICwgTI93TYhmqNFSsuM8azcmS+AeD9jCRtmjL
	KDroXupo5I//O7JLV3lqdbnM9PejC/hPo27TvagD5IuZk42MM45LQmN/NuMOdK02
	EJJhrzDXbjSjgI6n1hYEGUnEHtMSucClrwyIxhzYB0DhHrVWMeommzuZd1ubJF0n
	SiVHDgK3/YhwJIqfLNiq7NBQSN3HD0/8zN7VuyaQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw518rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 10:42:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669AZ2L9030278;
	Thu, 9 Jul 2026 10:42:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hmm9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 10:42:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669AgpKc31457636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 10:42:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B33F32004E;
	Thu,  9 Jul 2026 10:42:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73BE120043;
	Thu,  9 Jul 2026 10:42:51 +0000 (GMT)
Received: from localhost (unknown [9.111.0.64])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 10:42:51 +0000 (GMT)
Date: Thu, 9 Jul 2026 12:42:50 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/uapi: Remove obsolete unistd_32.h from Kbuild file
Message-ID: <tthwlre@ub.hpns>
References: <20260701134727.882734-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701134727.882734-1-thuth@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MvF6PstUuoIKDSRGqZz4nR4ERMWBjR-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfX8++Jc/h5Ndyv
 h6fDZyuN8SIuB18BBKFP79fBBxF70Fkoe3dhrNVDz7K9tLLiQz4BdNre+UYCiRDw5ti3BpWjEqO
 7EbtyN6NwtILMDRDXStuvALIHciWNt84Rnv6McCI+RYeVAU0mi6+eKuLKieJCZ+TJauJpSvaT0e
 RQ5xY4uMh019iGX3+Q5WsZFpkAIDacZtvu4qutiikleHnl6XrhEOuVZ8DraoF2tUpzkREPaTuzT
 h0a8sFpOORj6taPoHmksr1Mz6mFIE5G0rdMfwLALvk/jJGgswaviSNwuBY6k1kQJ3Okc8nRBwJ7
 k4VwrbdRbaY07atUdnJnDimLbnHlN+wkfJ8FSB7Schw204dVGeMPhI37hnQO2t3bkavecA90/Pi
 Mh0UuoZOUBAwgxeDr3ypoNAZyAKtU5RT+d44KQgJHRZdSwgJ4ay0p1f2xYePnOGzAYeuCJELIb9
 Sx3qMQYPHvZgAujNJdA==
X-Proofpoint-ORIG-GUID: MvF6PstUuoIKDSRGqZz4nR4ERMWBjR-K
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4f7b31 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=e9PFnbqw4GJfFSNQJooA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfXxQBjYJn1pAIi
 bcCXKzDVxhOFBp7pkoql3/Fd2lRqn9mwzbrzENJiQDIg4sDC+A3TrBQWRPqwEDKdyovsBa61BW2
 +UEvdNX3emVFTtTFDw82td7SjWNtM9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thuth@redhat.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gor@linux.ibm.com,linux-s390@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21922-lists,linux-s390=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ub.hpns:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gor@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7445772FCF8

On Wed, Jul 01, 2026 at 03:47:27PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> unistd_32.h is not build anymore since commit 4ac286c4a8d90
> ("s390/syscalls: Switch to generic system call table generation").
> Thus drop the superfluous line from the Kbuild file now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/include/uapi/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Applied, thank you!

