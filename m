Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1850C618CE7
	for <lists+linux-s390@lfdr.de>; Fri,  4 Nov 2022 00:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKCXo4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 3 Nov 2022 19:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCXoz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Nov 2022 19:44:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299941F2DD;
        Thu,  3 Nov 2022 16:44:55 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3Mfwhi005516;
        Thu, 3 Nov 2022 23:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qF9vS5ammTEfPQcbbkkkL4WyWczf78uds1znirT0NrE=;
 b=SxMkkorV3q2nKqNbdvaU0exG/y8jPqi3ddTlYxNZJNYzLZ/6dIv/nVRa36GkDimbT76F
 C7q9pxkJO918yX03lAYX7rSG/r+QTp+qpRUiTKt/Zkc12TDDb5ymVlXWuwxk2FFOLveu
 mQznGScm+XnllL1STDS7ObXsnRJ4Mu1ZrfuVJWae1E///labXdAFKvFC6t2/jFWRJlo1
 iPPkW8tnv1GktPDuzuSU5xLgxJAtKDakPOcacu9Im0STsCYrLBEe4TcTI6LuN6ihKuLG
 L511bFm+qrpUOSgVAParNmgs/ZxHz/2oOMG0unIKFYQHGmxm5v7m9A2Bo/hR15cwgO+c kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmpjeskt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 23:43:38 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A3Mx46q034111;
        Thu, 3 Nov 2022 23:43:37 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmpjesksm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 23:43:37 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3NYm5F030971;
        Thu, 3 Nov 2022 23:43:36 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 3kgutawqf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 23:43:36 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3NhZ7E3670556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 23:43:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E55D85805A;
        Thu,  3 Nov 2022 23:43:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAA2258058;
        Thu,  3 Nov 2022 23:43:27 +0000 (GMT)
Received: from [9.65.206.126] (unknown [9.65.206.126])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 23:43:27 +0000 (GMT)
Message-ID: <a408e8c7-6bd6-80de-5e59-815cb62fe29c@linux.ibm.com>
Date:   Thu, 3 Nov 2022 19:43:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 0/7] vfio-ccw parent rework
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Farman <farman@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
References: <20221102150152.2521475-1-farman@linux.ibm.com>
 <20221103155611.0008075f.alex.williamson@redhat.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221103155611.0008075f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vGKFL-a887GxkzLXxnbq8AP0IVxLXGkh
X-Proofpoint-ORIG-GUID: AT3jwI0nyFADvxaKE7-1YPKVRqTAuTD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030161
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/3/22 5:56 PM, Alex Williamson wrote:
> On Wed,  2 Nov 2022 16:01:45 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> Hi all,
>>
>> Here is an update to the vfio-ccw lifecycle changes that have been discussed
>> in various forms over the past year [1][2] or so, and which I dusted off
>> recently.
>>
>> Patches 1-5 rework the behavior of the vfio-ccw driver's private struct.
>> In summary, the mdev pieces are split out of vfio_ccw_private and into a
>> new vfio_ccw_parent struct that will continue to follow today's lifecycle.
>> The remainder (bulk) of the private struct moves to follow the mdev
>> probe/remove pair. There's opportunity for further separation of the
>> things in the private struct, which would simplify some of the vfio-ccw
>> code, but it got too hairy as I started that. Once vfio-ccw is no longer
>> considered unique, those cleanups can happen at our leisure. 
>>
>> Patch 6 removes the trickery where vfio-ccw uses vfio_init_device instead of
>> vfio_alloc_device, and thus removes vfio_init_device from the outside world.
>>
>> Patch 7 removes vfio_free_device from vfio-ccw and the other drivers (hello,
>> CC list!), letting it be handled by vfio_device_release directly.
> 
> Looks like another spin is pending, but the vfio core and collateral
> changes in 6 and 7 look good to me.  Would this go in through the vfio
> or s390 tree?  I'd be happy to merge or provide a branch, depending on
> the route.
> 
> For 6 & 7:
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> 
> Thanks,
> Alex

LGTM with those few comments addressed -- @Eric please send a v3 and I think it's ready.

I would suggest vfio tree to reduce the chance of conflicts; this touches various vfio drivers (and main) with the last patches while the s390 hits are at least all contained to the vfio-ccw driver code.

