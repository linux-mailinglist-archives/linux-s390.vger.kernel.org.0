Return-Path: <linux-s390+bounces-346-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5AE806AA8
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 10:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EDE1F21101
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 09:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38A01A71C;
	Wed,  6 Dec 2023 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lL3rjPyK"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7620F10FE;
	Wed,  6 Dec 2023 01:15:48 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B696Bhg029858;
	Wed, 6 Dec 2023 09:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=SWtYvFRREdIALVKLyDoSVDr17RVjA3EfSR1TRvntPyA=;
 b=lL3rjPyKF+yzmi8hT15gFLdzY4IRDvlLDLfUy08zMc+10toOblwHlL61hxrF4FbLlgNm
 sKrshiU1ZoD+J/q7JCrmT4SezfU7SmZQi3qxOhk/xkOE8zM5iwRnAQYNFwRwEbRhGJx7
 dqLNPur/JQ2X74sFwi5MfwrbPUQ30fDaSbyuluC1Oz7LtbiARDqW0X/NaGfo54F3D+ii
 97hWoqU3K72AcY7PaYaaMfZq+6Q5FCxi9Zyj2Rgb/Q8iIV1dcDeKR++NZ6SqAeTqVE9/
 VPSss/Amn9SsUKM9FUVwPAi4dzZwK8uyMKceetIIa5oV9Tx93MmSgLQe6m4oqSa1KzzF ZA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utnw5rf4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 09:15:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B68iISK012978;
	Wed, 6 Dec 2023 09:15:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utavjkceu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 09:15:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B69FhYe27853392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 09:15:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 414CF20074;
	Wed,  6 Dec 2023 09:15:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 094B520063;
	Wed,  6 Dec 2023 09:15:43 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Dec 2023 09:15:42 +0000 (GMT)
Date: Wed, 6 Dec 2023 10:15:41 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        nsg@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390: mm: convert pgste locking functions to C
Message-ID: <20231206091541.6897-A-hca@linux.ibm.com>
References: <20231205173252.62305-1-imbrenda@linux.ibm.com>
 <ZXA4XkU0M1BZ5R5k@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXA4XkU0M1BZ5R5k@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _8WngSJqXJ2xVMxhWcdvX0MIuhbApuBu
X-Proofpoint-ORIG-GUID: _8WngSJqXJ2xVMxhWcdvX0MIuhbApuBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_06,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 mlxlogscore=389
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060074

On Wed, Dec 06, 2023 at 10:01:18AM +0100, Alexander Gordeev wrote:
> On Tue, Dec 05, 2023 at 06:32:52PM +0100, Claudio Imbrenda wrote:
> ...
> > +	do {
> > +		value = __atomic64_or_barrier(PGSTE_PCL_BIT, ptr);
> 
> Would it make sense to cpu_relax() here, e.g with a follow-up patch?

No, because cpu_relax() is a no-op on our architecture (besides that it
translates to barrier(); but __atomic64_or_barrier() obviously comes also
with barrier() semantics).

We used to do diag 0x44 with cpu_relax() but that caused many performance
problems, therefore we removed diag 0x44 completely from the kernel quite
some time ago.

See also commit 1b68ac8678a8 ("s390: remove last diag 0x44 caller").

