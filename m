Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224C2628F1A
	for <lists+linux-s390@lfdr.de>; Tue, 15 Nov 2022 02:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiKOBRn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Nov 2022 20:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiKOBR2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Nov 2022 20:17:28 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B48315FE4;
        Mon, 14 Nov 2022 17:17:27 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF144Em011372;
        Tue, 15 Nov 2022 01:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=v5qxHwZRSrEklg/Y29DH5jcZrOETt0IZmMrBfAAu1uo=;
 b=j2duxABM1EDylhhv6JusTSHWzMM/i/16Yd11mUx9/9rD20+6LkwQ8wzd1tEBiMDPoLOA
 K+XuU5Q0kNTJbpNsxQoECmfc1ofk1h87TnVa6ch6Tmvlt2d9tC6ZFzm+uvemgGOs0q7Y
 +V3I2Fx/666sTUU+Eprb5uful5OsKwvaPjvd6g1rU0N0j4a2ebncyMenLxju0oT8nO7Z
 g5EIg6wO0DLOvJh/9KYnbX7j/OkHcRdhukd1Lv6018XiWdxG9SJARMXsK8PxosGLwhTW
 mXMASPxbL+hQ0EG7iXpXw6KbE486T8vP60IH+2I6vktGBw+zxFi1jqPdqfOPl61gFMl7 Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv0sg886d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 01:17:04 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AF14mhU013878;
        Tue, 15 Nov 2022 01:17:04 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv0sg885y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 01:17:04 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AF16UOF023719;
        Tue, 15 Nov 2022 01:17:02 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 3kt349dft8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 01:17:02 +0000
Received: from smtpav04.dal12v.mail.ibm.com ([9.208.128.131])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AF1H23x8585858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 01:17:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9010A58052;
        Tue, 15 Nov 2022 01:17:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91EA25804E;
        Tue, 15 Nov 2022 01:16:57 +0000 (GMT)
Received: from [9.160.3.49] (unknown [9.160.3.49])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 15 Nov 2022 01:16:57 +0000 (GMT)
Message-ID: <41c38082-bdc6-4df0-6fc3-8c8fe307dfa4@linux.ibm.com>
Date:   Mon, 14 Nov 2022 20:16:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 00/11] Connect VFIO to IOMMUFD
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Airlie <airlied@gmail.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        dri-devel@lists.freedesktop.org,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, iommu@lists.linux.dev,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <0-v2-65016290f146+33e-vfio_iommufd_jgg@nvidia.com>
 <Y2ofNKmmAIMGYLFK@Asurada-Nvidia>
 <9b2bb9f2-fc82-dd01-84ff-c2fe45e1a48a@intel.com>
 <Y2vb4fuPZdYKR1M1@nvidia.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <Y2vb4fuPZdYKR1M1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XhP4FCrn3gfeRfda6c43jYijtyrx4oqp
X-Proofpoint-ORIG-GUID: cKSFtegJBR8Bg-fuisl7smJ4mDwyk76N
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/9/22 11:57 AM, Jason Gunthorpe wrote:
> On Tue, Nov 08, 2022 at 11:18:03PM +0800, Yi Liu wrote:
>> On 2022/11/8 17:19, Nicolin Chen wrote:
>>> On Mon, Nov 07, 2022 at 08:52:44PM -0400, Jason Gunthorpe wrote:
>>>
>>>> This is on github: https://github.com/jgunthorpe/linux/commits/vfio_iommufd
>>> [...]
>>>> v2:
>>>>   - Rebase to v6.1-rc3, v4 iommufd series
>>>>   - Fixup comments and commit messages from list remarks
>>>>   - Fix leaking of the iommufd for mdevs
>>>>   - New patch to fix vfio modaliases when vfio container is disabled
>>>>   - Add a dmesg once when the iommufd provided /dev/vfio/vfio is opened
>>>>     to signal that iommufd is providing this
>>>
>>> I've redone my previous sanity tests. Except those reported bugs,
>>> things look fine. Once we fix those issues, GVT and other modules
>>> can run some more stressful tests, I think.
>>
>> our side is also starting test (gvt, nic passthrough) this version. need to
>> wait a while for the result.
> 
> I've updated the branches with the two functional fixes discussed on
> the list plus all the doc updates.
> 

For s390, tested vfio-pci against some data mover workloads using QEMU on s390x with CONFIG_VFIO_CONTAINER=y and =n using zPCI interpretation assists (over ism/SMC-D, mlx5 and NVMe) and without zPCI interpretation assists (over mlx5 and NVMe) - will continue testing with more aggressive workloads.  
(I did not run with CONFIG_IOMMUFD_TEST other than when building the selftest, but I see you mentioned this to Yi -- I'll incorporate that setting into future runs.)

Ran the self-tests on s390 in LPAR and within a QEMU guest -- all tests pass (used 1M hugepages)

Did light regression testing of vfio-ap and vfio-ccw on s390x with CONFIG_VFIO_CONTAINER=y and =n.

Didn't see it in your branch yet, but also verified the proposed change to iommufd_fill_cap_dma_avail (.avail = U32_MAX) would work as expected.

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> 


