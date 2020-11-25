Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B745C2C3B64
	for <lists+linux-s390@lfdr.de>; Wed, 25 Nov 2020 09:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgKYIwF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 25 Nov 2020 03:52:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26032 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgKYIwF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 03:52:05 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AP8Vc3D057306;
        Wed, 25 Nov 2020 03:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=35Fk6ONSviT5Geg1m+Wam/Zcba+8TpBwW1rVN0DhJ2U=;
 b=SHHrwBJ2Entck6pYwHPQx4rjEOhRZSPKIz/cZZ09WPwnEqPnMMhXLezX7bCRQmcI/BFH
 QCwtJIVRkK/bHEQJVmKPco35z5PxnlPpQq5f+0jeq31y4HHCRQ7gj6Uwp6p/0+HjWZuB
 dG3LyDjPwaszjMJaDupTA8XUoeMMG/wWt8XzvbmQ5eFY7VIbE4ZvlMvPCu3PoEA0Vrxa
 X5CV+1T8RhJL3ePQp8s3/62kb1WVMK5F3339W7+2OYIx9DzfPnOOYcLOIFr7h80H62jM
 gWupc2bEOqyFhBYpaWiKJJFgcPgF+MIW743ehpMVfierGHW6LzfDdk9gp8jF+8+lI0Pi JA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ygtusre6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 03:52:00 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AP8mDwQ005005;
        Wed, 25 Nov 2020 08:51:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34xt5hcg1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 08:51:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AP8pmRf38797706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 08:51:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 927254C050;
        Wed, 25 Nov 2020 08:51:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43C6C4C052;
        Wed, 25 Nov 2020 08:51:48 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.42.159])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Nov 2020 08:51:48 +0000 (GMT)
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
To:     Christoph Hellwig <hch@lst.de>, Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20200915154340.4215-1-hca@linux.ibm.com>
 <20200915154340.4215-5-hca@linux.ibm.com> <20200915160243.GB22056@lst.de>
 <20200915193755.GA8528@osiris> <20200916123603.GC7076@osiris>
 <20201125083808.GB31753@lst.de>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <72753cc5-e9a9-05c5-c465-6dff9fcf679d@de.ibm.com>
Date:   Wed, 25 Nov 2020 09:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20201125083808.GB31753@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_04:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 malwarescore=0 mlxlogscore=623 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250048
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 25.11.20 09:38, Christoph Hellwig wrote:
> On Wed, Sep 16, 2020 at 02:36:03PM +0200, Heiko Carstens wrote:
>> So, I can think of several ways to fix this (or better: make this
>> robust). However given that I will be away the next two weeks this is
>> not going to happen for the upcoming merge window. I really don't want
>> to rush this, since this has potential for severe subtle bugs... like
>> we had them already several times with our address space and dynamic
>> page table upgrade handling in the past (and like I nearly introduced
>> at least one bug with this patch).
>>
>> Therefore the first three patches of this series are scheduled for the
>> upcoming merge window, while the final set_fs() removal should come
>> one merge later.
> 
> Did you manage to get back to the s390 set_fs removal?
> 

Heiko has queued the following:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=87d5986345219a7e4f204726d9085ea87f3e22d0
