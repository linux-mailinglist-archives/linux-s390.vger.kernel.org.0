Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2061962A
	for <lists+linux-s390@lfdr.de>; Fri,  4 Nov 2022 13:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiKDMYD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 4 Nov 2022 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKDMYC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Nov 2022 08:24:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D1A2034F;
        Fri,  4 Nov 2022 05:24:01 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4C61tZ015880;
        Fri, 4 Nov 2022 12:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PwQ1Q0ZosR1g7PpBBp8cCx7OiB3HdSRlnPe7+yKMtAs=;
 b=sdek4q0Y6aGebL3YXsqiufuN6mavKD42MTtzjmxo0snDAG/la+P4Qd9Q96pad7eYpS+Z
 NsSgptzsq5b+kQK/bvAFtckd2g7x0Ck+vQVSSBkiN9tWoDabJMTYQrmTJZyMk+pOTVaj
 jgrKZ592g5i1prm/n9+Ty3Q9tUVFzU2rOd3cyr/2sCbwBVzMPcbiY6lMQ1WflXScbDLS
 C5N4oMtElrNvFYunJVXY7Ac8dHVkhlVmRmyuf5K7+LPmSrv0jm/qbdPBQ0Eo/zftfwsC
 I24DQaYVGqzyOi4mUqG8COP+YUKXm8w6tLy8LM+1ZjDzlMmHE3TNhtJhoVQdQXrFuKWw AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kn24612e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 12:23:46 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A4C6DMV017947;
        Fri, 4 Nov 2022 12:23:45 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kn24612dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 12:23:45 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A4CKscH014734;
        Fri, 4 Nov 2022 12:23:44 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3kgutb20e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 12:23:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A4CNgsW31326572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Nov 2022 12:23:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AFF658054;
        Fri,  4 Nov 2022 12:23:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4486C5805E;
        Fri,  4 Nov 2022 12:23:38 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.65.225.56])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Nov 2022 12:23:38 +0000 (GMT)
Message-ID: <611fd3a62596226e78af36909618ae65df615428.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/7] vfio-ccw parent rework
From:   Eric Farman <farman@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>
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
Date:   Fri, 04 Nov 2022 08:23:37 -0400
In-Reply-To: <a408e8c7-6bd6-80de-5e59-815cb62fe29c@linux.ibm.com>
References: <20221102150152.2521475-1-farman@linux.ibm.com>
         <20221103155611.0008075f.alex.williamson@redhat.com>
         <a408e8c7-6bd6-80de-5e59-815cb62fe29c@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CxcqPhpEQvuznc5i6jCT3LsyQXd7zf7o
X-Proofpoint-GUID: uW7VwR3E5qlArM97JsMblIX0nESJX9vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_07,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 2022-11-03 at 19:43 -0400, Matthew Rosato wrote:
> On 11/3/22 5:56 PM, Alex Williamson wrote:
> > On Wed,=C2=A0 2 Nov 2022 16:01:45 +0100
> > Eric Farman <farman@linux.ibm.com> wrote:
> >=20
> > > Hi all,
> > >=20
> > > Here is an update to the vfio-ccw lifecycle changes that have
> > > been discussed
> > > in various forms over the past year [1][2] or so, and which I
> > > dusted off
> > > recently.
> > >=20
> > > Patches 1-5 rework the behavior of the vfio-ccw driver's private
> > > struct.
> > > In summary, the mdev pieces are split out of vfio_ccw_private and
> > > into a
> > > new vfio_ccw_parent struct that will continue to follow today's
> > > lifecycle.
> > > The remainder (bulk) of the private struct moves to follow the
> > > mdev
> > > probe/remove pair. There's opportunity for further separation of
> > > the
> > > things in the private struct, which would simplify some of the
> > > vfio-ccw
> > > code, but it got too hairy as I started that. Once vfio-ccw is no
> > > longer
> > > considered unique, those cleanups can happen at our leisure.=20
> > >=20
> > > Patch 6 removes the trickery where vfio-ccw uses vfio_init_device
> > > instead of
> > > vfio_alloc_device, and thus removes vfio_init_device from the
> > > outside world.
> > >=20
> > > Patch 7 removes vfio_free_device from vfio-ccw and the other
> > > drivers (hello,
> > > CC list!), letting it be handled by vfio_device_release directly.
> >=20
> > Looks like another spin is pending, but the vfio core and
> > collateral
> > changes in 6 and 7 look good to me.=C2=A0 Would this go in through the
> > vfio
> > or s390 tree?=C2=A0 I'd be happy to merge or provide a branch, dependin=
g
> > on
> > the route.
> >=20
> > For 6 & 7:
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >=20
> > Thanks,
> > Alex
>=20
> LGTM with those few comments addressed -- @Eric please send a v3 and
> I think it's ready.

Will do that now; thanks Matt.

>=20
> I would suggest vfio tree to reduce the chance of conflicts; this
> touches various vfio drivers (and main) with the last patches while
> the s390 hits are at least all contained to the vfio-ccw driver code.
>=20

Agreed. Thanks to you both.
