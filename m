Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226B353CAA1
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jun 2022 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbiFCNZ2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Jun 2022 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiFCNZ1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jun 2022 09:25:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15918369F4;
        Fri,  3 Jun 2022 06:25:27 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253DLW9j020979;
        Fri, 3 Jun 2022 13:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+Zf338zkEiU/mOi0UuasHVKBOr1MVNOXh3P4N7thvfw=;
 b=PYHuvAvOk9IR3tvlSMbYGhIg2GGaMZTG0DJOlbQmvwCQKvz+BZ9egTsyBQK0GOgbJlWm
 2+PC4z/9J2+b1+M7ifyUryzuzBdSpt/Uh6Csbw6VY53MBI2Nru3J3mHU9SNJcrupHeKr
 Z7WyX2cmVs5y1rVf7QAVGbMD30agLgX5WxnTVbYQYcGLkyCFTfg47aeHQj6oIxqGwNd3
 bSDHqTTKjuwyoAiGuKIGQPFUBCz8mPUd2BzijXBJ7UEU6c73Yy1GGz3njudqrmU/DNI8
 dvP4PMsdhNKNWajlRgTXaAZP3qeRjX2WGyEVBtBtlh7+QymH1WOel2jWZ1b6GCDnFcsK Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfk460293-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:25:23 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253DPN7v007661;
        Fri, 3 Jun 2022 13:25:23 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfk46028s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:25:23 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253DK4ee016910;
        Fri, 3 Jun 2022 13:25:22 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3gbc939ge2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:25:22 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253DPLXh33882488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 13:25:21 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCA7E6A04D;
        Fri,  3 Jun 2022 13:25:21 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E42396A04F;
        Fri,  3 Jun 2022 13:25:20 +0000 (GMT)
Received: from [9.211.104.178] (unknown [9.211.104.178])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 13:25:20 +0000 (GMT)
Message-ID: <65153af9-be41-8f20-98f1-bc047518c3ae@linux.ibm.com>
Date:   Fri, 3 Jun 2022 09:25:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 03/18] vfio/ccw: Ensure mdev->dev is cleared on mdev
 remove
Content-Language: en-US
To:     Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        "Jason J. Herne" <jjherne@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20220602171948.2790690-1-farman@linux.ibm.com>
 <20220602171948.2790690-4-farman@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20220602171948.2790690-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GMgtB5JHcUlYyHEwyoUHooKz9u42eIx7
X-Proofpoint-ORIG-GUID: gU0UF4dgf7Ep36zd8fe2I-B7k7mtNQn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030057
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 6/2/22 1:19 PM, Eric Farman wrote:
> The mdev is linked with the vfio_ccw_private pointer when the mdev
> is probed, but it's not cleared once the mdev is removed.
> 
> This isn't much of a concern based on the current device lifecycle,
> but fix it so that things make sense in later shuffling.
> 
> Fixes: 3bf1311f351ef ("vfio/ccw: Convert to use vfio_register_emulated_iommu_dev()")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_ops.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index a403d059a4e6..a0a3200b0b04 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -159,6 +159,7 @@ static void vfio_ccw_mdev_remove(struct mdev_device *mdev)
>   			   private->sch->schid.ssid,
>   			   private->sch->schid.sch_no);
>   
> +	dev_set_drvdata(&mdev->dev, NULL);
>   	vfio_unregister_group_dev(&private->vdev);
>   
>   	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&

Seems harmless enough.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

But is this just precautionary or is it fixing a real problem (if the 
former I don't think a fixes tag makes sense)

I also ask because I note vfio-ap clears its driver_data in mdev_remove 
but also leaves the pointer set, meaning they might need a similar 
cleanup and should probably have a look (CC Tony & Jason H)
