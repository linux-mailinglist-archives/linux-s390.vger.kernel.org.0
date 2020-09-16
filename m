Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A304D26C5E5
	for <lists+linux-s390@lfdr.de>; Wed, 16 Sep 2020 19:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgIPRYR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Sep 2020 13:24:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbgIPRVy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Sep 2020 13:21:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GCWkCP176251;
        Wed, 16 Sep 2020 08:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ShvOb1E7xUOcPChge0x/ZXTtBQWeHaQ9jBqqbPUw1VE=;
 b=skbRe3QXDVEiBTOWCiYEctj9QndFkqve0E7BezNEyFumGYc4WKrUO7vwxGP0j/PK3TPE
 X5bzZ9/0hvsejFbkXSFcJV12V8kwmbuoFMtmyB7eYzm/jt683y5gUXeOGww+GD1fyJ7m
 NGNkjQ5WZuN+CS2mYDZNWIA6nYNwpt6+iK++3uhsuXYyElUNnjGzaqpw1ncoCTrJSlpv
 w4xKYj8GXUW0/NnKP+KeOl+KruSCLhfpCZXMlDI0rbPkx6hgoqcXcPvtRtSQk2oJbFSk
 L74QjB1PenFDsO7v2ZF2w/NedKmSDYzep8hGPW7eeLnHMrcRHvpCRrYsC+K172COCtql TQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33kfv65vgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 08:36:10 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GCWs1h018423;
        Wed, 16 Sep 2020 12:36:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 33k5v98baj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 12:36:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GCa50o24248776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 12:36:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECE804C040;
        Wed, 16 Sep 2020 12:36:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B25964C046;
        Wed, 16 Sep 2020 12:36:04 +0000 (GMT)
Received: from osiris (unknown [9.171.80.23])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Sep 2020 12:36:04 +0000 (GMT)
Date:   Wed, 16 Sep 2020 14:36:03 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Message-ID: <20200916123603.GC7076@osiris>
References: <20200915154340.4215-1-hca@linux.ibm.com>
 <20200915154340.4215-5-hca@linux.ibm.com>
 <20200915160243.GB22056@lst.de>
 <20200915193755.GA8528@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915193755.GA8528@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_07:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=8 malwarescore=0 suspectscore=1
 clxscore=1015 mlxscore=8 spamscore=8 phishscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=109
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160092
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 15, 2020 at 09:37:55PM +0200, Heiko Carstens wrote:
> On Tue, Sep 15, 2020 at 06:02:43PM +0200, Christoph Hellwig wrote:
> > That logic always confused me and still keeps confusing me,
> > dumb questions below:
...
> > > +	bool old;
> > >  
> > > -	old_fs = enable_sacf_uaccess();
> > > +	old = enable_sacf_uaccess();
> > >  	switch (op) {
> > >  	case FUTEX_OP_SET:
> > >  		__futex_atomic_op("lr %2,%5\n",
> > > @@ -53,7 +53,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
> > >  	default:
> > >  		ret = -ENOSYS;
> > >  	}
> > > -	disable_sacf_uaccess(old_fs);
> > > +	disable_sacf_uaccess(old);
> > 
> > Do we need to return the old value here?  The way I understand it
> > this is context switched with the thread, and given that only small
> > isolated code bases now use it, sacf use can't nest, can it?
> 
> I just realized that this is broken for uaccess in irq context
> (e.g. copy_from_user_nofault()). With set_fs() removal the calls to
> force_uaccess_begin()/end() will do nothing, while before
> set_fs(USER_DS) actually enforced that control registers on s390 were
> setup correctly.
> This wouldn't be the case anymore now. If e.g. a code sequence within
> enable_sacf_uaccess() would be interrupted, and from within interrupt
> context copy_from_user_nofault() would be executed, this would read
> from kernel space instead from user space.
> 
> Needs fix.

So, I can think of several ways to fix this (or better: make this
robust). However given that I will be away the next two weeks this is
not going to happen for the upcoming merge window. I really don't want
to rush this, since this has potential for severe subtle bugs... like
we had them already several times with our address space and dynamic
page table upgrade handling in the past (and like I nearly introduced
at least one bug with this patch).

Therefore the first three patches of this series are scheduled for the
upcoming merge window, while the final set_fs() removal should come
one merge later.
