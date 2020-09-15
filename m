Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5755926AB23
	for <lists+linux-s390@lfdr.de>; Tue, 15 Sep 2020 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgIORwB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Sep 2020 13:52:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727955AbgIORsd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 13:48:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FGWLTx190755;
        Tue, 15 Sep 2020 12:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Ho6yGie/c2qf0iMAeWXvwp4n8dL1Xm31ZPjHo5nT+ts=;
 b=reFEOztTuCJsx8kYqxR5e+slQP6MuHfkR8IBZhav5pkRmeSjLC9lpP03rwfyFLt9pFWu
 Z6IO9ZREppQRC5h8zkhMfsrBOf0Ux1aC19hFKkZWqGvDydnfa+QyxIPDOun0tTMMFaU3
 KaDUJL970Z8QHQFst5PUzE6PbXwR9fbtGP2G8VF/jVlWBI2NCEkSXamDXYvxORWNdiD4
 Dgm0TaANYHIv+bcfHZ/dsRYYbH2B10sg46icK+KNF7F/5LZ2rIQxyQeoeVztuALBKyBP
 tZWH7wq7YZAyh0ifrWQbECRnCXkVzrwvg2rTp1RYkMusWc20cJta+TF4VPJP9+ClQqwT JQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33k07f2g00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 12:55:25 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FGgiOH019774;
        Tue, 15 Sep 2020 16:55:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 33hjgdsbjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 16:55:22 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FGtJu428901656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 16:55:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3581FA405B;
        Tue, 15 Sep 2020 16:55:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4E31A405F;
        Tue, 15 Sep 2020 16:55:18 +0000 (GMT)
Received: from osiris (unknown [9.171.78.178])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Sep 2020 16:55:18 +0000 (GMT)
Date:   Tue, 15 Sep 2020 18:55:17 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] s390/dis: get rid of set_fs() usage
Message-ID: <20200915165517.GC11180@osiris>
References: <20200915154340.4215-1-hca@linux.ibm.com>
 <20200915154340.4215-3-hca@linux.ibm.com>
 <20200915155217.GA22056@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915155217.GA22056@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=766 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150130
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 15, 2020 at 05:52:17PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 15, 2020 at 05:43:38PM +0200, Heiko Carstens wrote:
> > +		if (user_mode(regs)) {
> > +			if (__copy_from_user(code + start - 2, (char __user *)addr, 2))
> > +				break;
> > +		} else {
> > +			if (copy_from_kernel_nofault(code + start - 2, (char *)addr, 2))
> > +				break;
> > +		}
> 
> >  	for (end = 32; end < 64; end += 2) {
> >  		addr = regs->psw.addr + end - 32;
> > +		if (user_mode(regs)) {
> > +			if (__copy_from_user(code + end, (char __user *)addr, 2))
> > +				break;
> > +		} else {
> > +			if (copy_from_kernel_nofault(code + end, (char *)addr, 2))
> > +				break;
> > +		}
> 
> Maybe add a little copy_from_regs helper?  That would also get rid
> of the awfully long lines here.

Yes, I'll check how the result looks like, and will probably change
that.

> Also any good reason for the __copy_from_user instead of the normal
> copy_from_user here?

I don't see any reason. If I remember correctly the only difference is
zero padding, and that wouldn't hurt at all here.
Will check and change.

Thank you for taking a look!
