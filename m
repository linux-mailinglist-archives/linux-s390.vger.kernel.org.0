Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DB626ADBC
	for <lists+linux-s390@lfdr.de>; Tue, 15 Sep 2020 21:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgIOTi2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Sep 2020 15:38:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728014AbgIOTiI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 15:38:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FJWOYh051177;
        Tue, 15 Sep 2020 15:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BXfhZvhcmNgcmZzJlSBGselYPNAPxT2tmj8BEkXaM2Q=;
 b=nYB3IulpP8jNQ3de2ar9bvCAiECKzR+RByvEV/MIf25mj6TyssBuctTtzlrwZHWqE+KD
 GlYPVncrYft6O0klJbtx1erq2iQeAVxIeQbC2Y7CAyO67Tu/2j6BSVEN2MVVcniZ9xr5
 qMuqbSO+WpO5PNt7ocJatuMkeXmZnrH92atqDgZ21+ADX6szm9j0A6ziI9waJ9G4G7hS
 VE6cp4r36FatbrPhoOOvYdEseUgjlTrB88aOkm1qBV0Zs1eCvv5adKBrYY2+cdxBYfQU
 XR+GHSIvqQFHtNdEChIxrmtvQyLuf0rW1qElavmw5inVL5c2qq3bbRiy/xrLkLSeDU0W Bg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33k1wtujag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 15:38:02 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FJXBjm014224;
        Tue, 15 Sep 2020 19:38:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 33guvm1x1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 19:37:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FJbvaF19595680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 19:37:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01F1DA405D;
        Tue, 15 Sep 2020 19:37:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE0EFA405B;
        Tue, 15 Sep 2020 19:37:56 +0000 (GMT)
Received: from osiris (unknown [9.171.26.235])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Sep 2020 19:37:56 +0000 (GMT)
Date:   Tue, 15 Sep 2020 21:37:55 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Message-ID: <20200915193755.GA8528@osiris>
References: <20200915154340.4215-1-hca@linux.ibm.com>
 <20200915154340.4215-5-hca@linux.ibm.com>
 <20200915160243.GB22056@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915160243.GB22056@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_13:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=1 clxscore=1015 malwarescore=0 mlxlogscore=560
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150149
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 15, 2020 at 06:02:43PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 15, 2020 at 05:43:40PM +0200, Heiko Carstens wrote:
> > Address spaces still have to switched/changed for machines without the
> > mvcos instructions and especially for instructions like e.g. compare
> > and swap (-> futex) which must be executed in kernel address space but
> > access user address space. For such instructions enable_sacf_uaccess()
> > and disable_sacf_uaccess() must be used like before.
> 
> That logic always confused me and still keeps confusing me,
> dumb questions below:
> 
> >  	int oldval = 0, newval, ret;
> > -	mm_segment_t old_fs;
> > +	bool old;
> >  
> > -	old_fs = enable_sacf_uaccess();
> > +	old = enable_sacf_uaccess();
> >  	switch (op) {
> >  	case FUTEX_OP_SET:
> >  		__futex_atomic_op("lr %2,%5\n",
> > @@ -53,7 +53,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
> >  	default:
> >  		ret = -ENOSYS;
> >  	}
> > -	disable_sacf_uaccess(old_fs);
> > +	disable_sacf_uaccess(old);
> 
> Do we need to return the old value here?  The way I understand it
> this is context switched with the thread, and given that only small
> isolated code bases now use it, sacf use can't nest, can it?

I just realized that this is broken for uaccess in irq context
(e.g. copy_from_user_nofault()). With set_fs() removal the calls to
force_uaccess_begin()/end() will do nothing, while before
set_fs(USER_DS) actually enforced that control registers on s390 were
setup correctly.
This wouldn't be the case anymore now. If e.g. a code sequence within
enable_sacf_uaccess() would be interrupted, and from within interrupt
context copy_from_user_nofault() would be executed, this would read
from kernel space instead from user space.

Needs fix.
