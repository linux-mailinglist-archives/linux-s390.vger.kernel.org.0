Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371AC2B6DA3
	for <lists+linux-s390@lfdr.de>; Tue, 17 Nov 2020 19:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgKQSnN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 17 Nov 2020 13:43:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726794AbgKQSnN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 13:43:13 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIVV8x060679
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RV44WmJb6eMautJdpAOTqHLVghIsy/XrljWOZPfMJ/k=;
 b=nRnURFIWIPDdf/OL4ylujtfTzw3WW9svNzsSxQB2yQqac/VaeTbwM/IWBB1jzzS7Zv7J
 Dh6N71LpmStOfWs4SiEaxk/haV9geSp4i+GZevChSlEYrMBe0KGGXe4NK74z97YGU5MV
 hoV1xaFSdAsPhZgJQzEYLYrAub3M0HpyQA/I81eunw/AP26THWAKzrbxdHZE3vamp+vT
 YTb2eUG9mSPjbsyvf9p84qLehKwxdXtB505ve00oAhPf7WlFXSlL+kV0V3NkXNIwMtEG
 zdYr6bBWj8/pam+A4lcZQiO3gTRZiZJMKEXezkAWKCBwj8Ugmy6kmlAN6IqLKOU2V/Wq 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ve31mycu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:43:12 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHIVX6g060818
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:43:11 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ve31myc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 13:43:11 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIh97f017632;
        Tue, 17 Nov 2020 18:43:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34t6v8bcdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 18:43:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AHIh7pY13435258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 18:43:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E1115204E;
        Tue, 17 Nov 2020 18:43:07 +0000 (GMT)
Received: from osiris (unknown [9.171.25.24])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2EDCD52051;
        Tue, 17 Nov 2020 18:43:07 +0000 (GMT)
Date:   Tue, 17 Nov 2020 19:43:05 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/3] s390/vmem: remove redundant check
Message-ID: <20201117184305.GD4746@osiris>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=995 suspectscore=1 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170131
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 10, 2020 at 10:36:21AM +0100, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/mm/vmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b09..56ab9bb770f3a 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -223,7 +223,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
>  		if (!add) {
>  			if (pmd_none(*pmd))
>  				continue;
> -			if (pmd_large(*pmd) && !add) {
> +			if (pmd_large(*pmd)) {

Applied, thanks!
