Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 745A616187F
	for <lists+linux-s390@lfdr.de>; Mon, 17 Feb 2020 18:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBQRHo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 17 Feb 2020 12:07:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgBQRHn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 12:07:43 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HH57vx021624
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:07:42 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6b55rtyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:07:42 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 17 Feb 2020 17:07:39 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Feb 2020 17:07:37 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01HH7ZNv46727478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 17:07:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F33CA405B;
        Mon, 17 Feb 2020 17:07:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 420EBA405F;
        Mon, 17 Feb 2020 17:07:35 +0000 (GMT)
Received: from localhost (unknown [9.152.212.204])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Feb 2020 17:07:35 +0000 (GMT)
Date:   Mon, 17 Feb 2020 18:07:33 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] s390/mm: Explicitly compare PAGE_DEFAULT_KEY against
 zero in storage_key_init_range
References: <20200214064207.10381-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214064207.10381-1-natechancellor@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 20021717-0020-0000-0000-000003AB0014
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021717-0021-0000-0000-00002202F820
Message-Id: <your-ad-here.call-01581959253-ext-9953@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_11:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002170139
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Feb 13, 2020 at 11:42:07PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>  In file included from ../arch/s390/purgatory/purgatory.c:10:
>  In file included from ../include/linux/kexec.h:18:
>  In file included from ../include/linux/crash_core.h:6:
>  In file included from ../include/linux/elfcore.h:5:
>  In file included from ../include/linux/user.h:1:
>  In file included from ../arch/s390/include/asm/user.h:11:
>  ../arch/s390/include/asm/page.h:45:6: warning: converting the result of
>  '<<' to a boolean always evaluates to false
>  [-Wtautological-constant-compare]
>          if (PAGE_DEFAULT_KEY)
>             ^
>  ../arch/s390/include/asm/page.h:23:44: note: expanded from macro
>  'PAGE_DEFAULT_KEY'
>  #define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
>                                                   ^
>  1 warning generated.
> 
> Explicitly compare this against zero to silence the warning as it is
> intended to be used in a boolean context.
> 
> Fixes: de3fa841e429 ("s390/mm: fix compile for PAGE_DEFAULT_KEY != 0")
> Link: https://github.com/ClangBuiltLinux/linux/issues/860
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
Applied to fixes, thanks

