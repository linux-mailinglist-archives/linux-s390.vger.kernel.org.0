Return-Path: <linux-s390+bounces-21024-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 553YA0X4NGoYlgYAu9opvQ
	(envelope-from <linux-s390+bounces-21024-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 10:05:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2536A4817
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 10:05:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=AQ+2lohk;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21024-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21024-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84E63308E066
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A640D579;
	Fri, 19 Jun 2026 08:02:57 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B12D7DE9;
	Fri, 19 Jun 2026 08:02:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856177; cv=none; b=hDevVAvgGyL1NW6TbzODAZej3W+aavlTZG5VrpocTF3gJosD24cF0T9TarpYb/RQNGqxSl7AURrT1nFkTST18IyGuabXgvwdIRwEJ6jKp9HC0OSJVjldk6IKHpnRti3mzOCPg8hGEzI33jfr69VsJSESMlxUERqdC+VeiA9oP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856177; c=relaxed/simple;
	bh=j/ekGBZ23rxTVqUIGAtaFX271w2kJDCmY0L3kwYqcrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAi6bOW+6gYKgN8KS9bFzRz8DvgDxnRwO1tY0P0JXI2Z3sKluUESMmqrq1g+QRbN2MRApa4X+AfYT4wyjP1rpx+yNQZnWhDhA2nigK/Tjx2aGEW6dWALYoiquTcBC0UlymEbmj3lnUkVyY21cSQvenpgr0x5rLvhptKiPvJ5uFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AQ+2lohk; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mOWI1840513;
	Fri, 19 Jun 2026 08:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WE36Gl
	C2QLlT24ILZJ0WI39AQniVN83jo/SKSSzGV44=; b=AQ+2lohk98qiE41PcS+1hg
	pQR9zForTj64lJ2nkeEsd0YCwYs/5YEWqTwG9eWjcx2PXzrEtlhupNJAvHc20qa2
	y+4zA0yHw9vNxxOCum282pSP8N6rqaX28u9omc1DFcYpw5AZ6XNv6+9HPfi7rGKV
	+y+W+crOmiXGVqtwRhy+DrD4XaQWakYabyxKYG9GvxTr1ZqROtGu3AKWv/Dujnge
	UEcYRNlOUisCMwZAu1p2AKPhxQzgTmrSRDou0FedZjU79eeZsXSaKtoWr4++24Rz
	e8K6yElZrnBYVSzCWaqFqN3R8ecZG/wHTuYkW7pTmUSHt7uyEFrejmJfGfha5Jzg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequcer5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 08:02:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J7ngig024958;
	Fri, 19 Jun 2026 08:02:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172fu1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 08:02:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J82osG61800734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 08:02:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CB5B2004F;
	Fri, 19 Jun 2026 08:02:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBB6E2004D;
	Fri, 19 Jun 2026 08:02:49 +0000 (GMT)
Received: from [9.111.75.212] (unknown [9.111.75.212])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 08:02:49 +0000 (GMT)
Message-ID: <536350a6-6b82-4b13-afc2-2cdbe3d6cf7f@linux.ibm.com>
Date: Fri, 19 Jun 2026 10:02:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
 <20260619074541.1710716-2-dengler@linux.ibm.com>
 <20260619080011.4E1A71F00A3D@smtp.kernel.org>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260619080011.4E1A71F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA3MSBTYWx0ZWRfX0MjvPTPgnj+o
 KYq6gx1HhqxXVdbPH5bPG1o+FJ8GlyjUidg8ZovE+mbPdNbXJ9OgyPd/iMCjtGns3NsxxvMYJS8
 UrJum7tnhBRRTaT8RAJFxjzGarvQE0E=
X-Proofpoint-ORIG-GUID: aeeBJ9Hg4LVn9cRGJWU4G9Uvsqkoqh9n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA3MSBTYWx0ZWRfX2jrp5/tp8CR4
 p3ZelOaB1Xqjl1bgyyDJZDh8bwks4NoN7Z7VTvmpgywADt/yUGnJUutM0hfbXiiUEHC5iZL298L
 HEHdalzviai44VEyK6oqafLdpdWixXH8fKhe8j3xJ3fE2+cwjnY+reIdmwQBbfENNAdnnY02GcI
 RxEgPF5O3VZqnzdqg7iDEAAQXInzj2xiF2mHblphAz/GB9v+U0yIcPsgQ2A41RH34Lt8phE8StE
 kAyOc9zCfAbW10qJw+uvhkiRKkXChB4PLYyXQWzRjkkjIQw11xFHvTCfJX69SCUPi7GMU3W0et7
 YqXwmj8W8JjMMmLSsDhO/vDVuQaR4eB0YhtzZ9jjeDLujh7itnKb5LDdcPBPMdCJaNyzHDSUExV
 YWTWV+As/Vl4hWBY37s1hArB4HiDXl24rMq/wXnkxWvSdN1VJRLCdDcwEpHpRgADNuZ+CzpC/KW
 wQLmJoFPF+7AWJbO43g==
X-Proofpoint-GUID: aeeBJ9Hg4LVn9cRGJWU4G9Uvsqkoqh9n
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a34f7af cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=K_X9F7hbqwqGGdNf0T4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21024-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[dengler@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dengler@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D2536A4817

On 6/19/26 10:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] An integer wrap-around in the key bit-size calculation bypasses length validation, leading to massive out-of-bounds memory accesses during a subsequent memcpy().
> --

This issue is already fixed and on its way.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler


