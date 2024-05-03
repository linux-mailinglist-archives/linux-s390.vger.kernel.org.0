Return-Path: <linux-s390+bounces-3801-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD5E8BA813
	for <lists+linux-s390@lfdr.de>; Fri,  3 May 2024 09:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0052E1F21C06
	for <lists+linux-s390@lfdr.de>; Fri,  3 May 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5682147C60;
	Fri,  3 May 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gR8/3huL"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7C139CF1;
	Fri,  3 May 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722666; cv=none; b=nEiwO64CZ/9Qh5xjOYhEIDLyvBiZ9W0y/idxoHGIGiopLSWCBRGKhjWtSJrLiWzjcO2QxiCc/EKWtaCRiRX3CKVZMnY3WIGMW43nZlQccba0T5FIupxsaCK9h9BjlcVjxR1q2JsaOmmSHXVVMluG+0qVMmr8EssFP8xzwXYU6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722666; c=relaxed/simple;
	bh=yIjNmxIML1FbsXVtMsyttZ8dFCoK45Lmn+U46u/czgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE8a0h+davp5/R/XIdLml1DmlTNBz5xHDkgjUYT5W9iB4L0AWzJ2jPIqJlXdp59O6LE1qha3sxt3YzHUWt7EO58aTs/V+XSCoAvCeHIdXNzbtVWiz1fXFWavWd2Z43/wP8DERIT3KkqMyH9sN+hRxBIgOwY8I9FU1qKdK56Y2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gR8/3huL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4437GHmD029492;
	Fri, 3 May 2024 07:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6TfG+m/b+Q0DJTgqARcvPfAZDfe6qFgeYAx1R3LLzJ0=;
 b=gR8/3huLDXEpZM7+E/FADsM9OV9y9I+ByO+S4rtcYc8z8VTDivV/PlPrN1KCnkh+IWMg
 7ZT657mB9WEu74Mk0CvQLH6ULTUxt7mMrX7mNBKCj0yAK3PlZTLQRnKY+EKuEcBXo0iG
 qpidM/lDDO/3YMt32/v5AG/yQbLo5kWTINH7xuZhvrX8svHTElSdDVYgRZewXJFZ+jSv
 gcf+Ic8CyJATd+n7wKbNIllKIDnEmIEQstH40Zk5R1QGGn0HJ4YEwo6XrbDlBaoPcvG4
 pDcHdMd6jEX29tNxtU47BNlIyuIs3hXXeFe9VBOZ0tHV9YdMSd6l0SWifA69y4y6XJdb sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvtp9g5p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 07:51:02 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4437p2ej019183;
	Fri, 3 May 2024 07:51:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvtp9g5ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 07:51:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44369Eel003622;
	Fri, 3 May 2024 07:51:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscppvgup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 07:51:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4437oter53150080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 May 2024 07:50:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C88AD20067;
	Fri,  3 May 2024 07:50:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CA9C2005A;
	Fri,  3 May 2024 07:50:55 +0000 (GMT)
Received: from osiris (unknown [9.171.17.237])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 May 2024 07:50:55 +0000 (GMT)
Date: Fri, 3 May 2024 09:50:53 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] s390: Remove comment about TIF_FPU
Message-ID: <20240503075053.9139-A-hca@linux.ibm.com>
References: <20240502172527.56835-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502172527.56835-1-thuth@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jBqv7RWMhwUeki5oK_uU5Z14dsFnZcBR
X-Proofpoint-GUID: Hnm-zw5HsnZbbfDxyQBBp5zBEMWLVvWf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_04,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 mlxlogscore=731
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030055

On Thu, May 02, 2024 at 07:25:27PM +0200, Thomas Huth wrote:
> It has been removed in commit 2c6b96762fbd ("s390/fpu: remove TIF_FPU"),
> so we should not mention TIF_FPU in the comment here anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/kernel/process.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> index dd456b475861..3e7df2e579f1 100644
> --- a/arch/s390/kernel/process.c
> +++ b/arch/s390/kernel/process.c
> @@ -88,8 +88,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  {
>  	/*
>  	 * Save the floating-point or vector register state of the current
> -	 * task and set the TIF_FPU flag to lazy restore the FPU register
> -	 * state when returning to user space.
> +	 * task.
>  	 */
>  	save_user_fpu_regs();

Could you change your patch to remove the whole comment instead, please?

Without the TIF_FPU part the comment becomes quite pointless, since it
only documents the obvious.

