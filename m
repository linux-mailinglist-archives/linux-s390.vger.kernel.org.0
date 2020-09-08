Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404F9261D03
	for <lists+linux-s390@lfdr.de>; Tue,  8 Sep 2020 21:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgIHT3y (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Sep 2020 15:29:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56306 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731021AbgIHP62 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 11:58:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088C2A7s083483;
        Tue, 8 Sep 2020 08:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=IIy7YCbdmkAGinScQBY8PxTdMyMAVk1trgEY205z6XM=;
 b=Or3aEEAXhzWN2slMZXeHMQdkZOsGzTkjoBVO0oSukkxRg6WtT99skEQy9hxIw8+dEvpJ
 vpjSvYYiXNpGkdIjjQi23YQ1yJ58GK6jmweVuIJWXLU39mW6AMII401dQup20NtCp8px
 a/zofu+0iyFTgCT/CA9JJCurqUMyNzxsjrpR4zidD5J1XGa3i+/C+mUlkBRXkQdDM9w0
 ZuF7y9Y97sqgHOX3B8cLpBpp6yOMBSpzxMs1OFIDr1CcmiHagV2CMYWpgGcfE4YpW1Ap
 Pp5fO6U6+ZZPwucNbUxASP3fP77l+BYNDCvis+0lphI6cy0TBw2EAZnbewbzUA8werNZ cg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33e939j6jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 08:26:43 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088CMrqb006874;
        Tue, 8 Sep 2020 12:26:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 33c2a823re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 12:26:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088CQdSi33489244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 12:26:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 090B342045;
        Tue,  8 Sep 2020 12:26:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BADB24203F;
        Tue,  8 Sep 2020 12:26:38 +0000 (GMT)
Received: from osiris (unknown [9.171.47.162])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Sep 2020 12:26:38 +0000 (GMT)
Date:   Tue, 8 Sep 2020 14:26:37 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: set_fs removal for s390
Message-ID: <20200908122637.GB14136@osiris>
References: <20200908063133.GA14217@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908063133.GA14217@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_06:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080108
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 08, 2020 at 08:31:33AM +0200, Christoph Hellwig wrote:
> Hi s390 maintainers,
> 
> the base work to remove address space overrides using set_fs() has
> landed in linux-next through this tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=base.set_fs
> 
> and in addition to x86 and powerpc converted there, we have arm, arm64
> and RISC-V conversion in progress.  That means s390 is the only "tier 1"
> architecture still missing.  Due to the special instructions for
> accessing the user space address space I don't really feel like doing
> the conversion myself, but it would be great if we could get s390 done
> for 5.10 as well.
> 
> The rought TODO list is:
>  (1) actually stop using set_fs in the zrcypt driver.  I could prepare
>      a crude untested patch for that if it helps.

Hmm.. Harald's initial implementation years ago was without set_fs(),
if I remember correctly, and then he was talked into using set_fs() ;)

Harald, can you take care of this part?

>  (2) implement the __get_user_nofault and __put_user_nofault helpers to
>      safely access kernel memory.  These should behave like
>      get_user/put_user under set_fs(KERNEL_DS), but not actually
>      manipulate any task state to do so
>  (3) unselect CONFIG_SET_FS and remove all the code related to overriding
>      the address space(3) unselect CONFIG_SET_FS and remove all the code
>      related to overriding the address space limit

Ok, I guess everything will have to land in vfs.git then.
