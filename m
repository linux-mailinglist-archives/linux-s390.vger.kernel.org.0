Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D95607A14
	for <lists+linux-s390@lfdr.de>; Fri, 21 Oct 2022 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJUPFv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 21 Oct 2022 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJUPFu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Oct 2022 11:05:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0026D1DCCCF;
        Fri, 21 Oct 2022 08:05:48 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LELGVk005189;
        Fri, 21 Oct 2022 15:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=eGQwYACBBdlJ+of5gf59HBFhtuCIWESCDUNLT6K+7Z0=;
 b=JHkmNhaTbzKLozsDnMaoAb+KTb6yNHMyBBt8EbxR4eolTFuZJ4P+hSw1ve/qcTFc6A8A
 ELhFWkl5zX2sE5/2ln6zmIfTaOJOQ/XbhtSMevoez5w0TxdLwLvCvQUBfjEYTT+iVUpr
 d7owqRoxHbJqeexU/sNak9pkXzDJv2/77F+6IjbZmS6GqpMyXIQ/MBocKmN+h8aiSL8z
 0VgMsVkf2qvMJ2jS2yGaKPBb/pprkyLjuvzUONm21Kg7Rqt1TwUOKq0QNUXOjsB8kCMB
 GdNEYr0nMFCOH+d4F9qXXzL6MY3NcMMb8qHneWaq5Pf7BjfNj4GKkvXSRFeVouJCJsb4 lA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kbw421g1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 15:05:32 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29LEoUw3022806;
        Fri, 21 Oct 2022 15:05:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3k7mg982q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 15:05:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29LF5Jit51184016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 15:05:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0017EA404D;
        Fri, 21 Oct 2022 15:05:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CB3CA4040;
        Fri, 21 Oct 2022 15:05:18 +0000 (GMT)
Received: from sig-9-145-0-12.uk.ibm.com (unknown [9.145.0.12])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Oct 2022 15:05:18 +0000 (GMT)
Message-ID: <12366a6d2a367de0e2a6f26ac9485e50a32aa7e6.camel@linux.ibm.com>
Subject: Re: [PATCH 3/5] iommu/s390: Use RCU to allow concurrent domain_list
 iteration
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Date:   Fri, 21 Oct 2022 17:05:17 +0200
In-Reply-To: <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
         <20221018145132.998866-4-schnelle@linux.ibm.com>
         <Y07Dz/NROAMI0Hku@nvidia.com>
         <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
         <Y0/lMCQ8oeXJ2HTg@nvidia.com>
         <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
         <Y1ErcEe82yjJI+ET@nvidia.com>
         <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
         <Y1KgX8EwH8T+FgWC@nvidia.com>
         <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yfa1-ZMbUzI6pGAXEC7wUTFJQGwfy7Ag
X-Proofpoint-ORIG-GUID: yfa1-ZMbUzI6pGAXEC7wUTFJQGwfy7Ag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=848 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 2022-10-21 at 17:01 +0200, Niklas Schnelle wrote:
> On Fri, 2022-10-21 at 10:36 -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 21, 2022 at 02:08:02PM +0200, Niklas Schnelle wrote:
> > > On Thu, 2022-10-20 at 08:05 -0300, Jason Gunthorpe wrote:
> > > > On Thu, Oct 20, 2022 at 10:51:10AM +0200, Niklas Schnelle wrote:
> > > > 
> > > > > Ok that makes sense thanks for the explanation. So yes my assessment is
> > > > > still that in this situation the IOTLB flush is architected to return
> > > > > an error that we can ignore. Not the most elegant I admit but at least
> > > > > it's simple. Alternatively I guess we could use call_rcu() to do the
> > > > > zpci_unregister_ioat() but I'm not sure how to then make sure that a
> > > > > subsequent zpci_register_ioat() only happens after that without adding
> > > > > too much more logic.
> > > > 
> > > > This won't work either as the domain could have been freed before the
> > > > call_rcu() happens, the domain needs to be detached synchronously
> > > > 
> > > > Jason
> > > 
> > > Yeah right, that is basically the same issue I was thinking of for a
> > > subsequent zpci_register_ioat(). What about the obvious one. Just call
> > > synchronize_rcu() before zpci_unregister_ioat()?
> > 
> > Ah, it can be done, but be prepared to wait >> 1s for synchronize_rcu
> > to complete in some cases.
> > 
> > What you have seems like it could be OK, just deal with the ugly racy
> > failure
> > 
> > Jason
> 
> I'd tend to go with synchronize_rcu(). It won't leave us with spurious
> error logs for the failed IOTLB flushes and as you said one expects
> detach to be synchronous. I don't think waiting in it will be a
> problem. But this is definitely something you're more of an expert on
> so I'll trust your judgement. Looking at other callers of
> synchronize_rcu() quite a few of them look to be in similar
> detach/release kind of situations though not sure how frequent and
> performance critical IOMMU domain detaching is in comparison.
> 
> Thanks,
> Niklas
> 

Addendum, of course independently of whether to use synchronize_rcu()
I'll change the error handling in the IOTLB ops to not skip over the
other devices.

