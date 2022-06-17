Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633EE54F366
	for <lists+linux-s390@lfdr.de>; Fri, 17 Jun 2022 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381191AbiFQIop (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 Jun 2022 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381202AbiFQIoj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Jun 2022 04:44:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F3F6972F;
        Fri, 17 Jun 2022 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cRcPliFH8a5nYGYbcpuAxJdVHyV2ltCZ23v97rgf1A4=; b=KiuwHF6aDNvC5t/LWv3aUEPzwE
        KBgvUpfkf5qDI6GElmlPwqGlCsWtGNTsSld0WuZewPo0/4mkHtzAiWM6dEK1eY4RySKpAlhO65R1D
        WAwqSuEBlSHCf5DkNowUItxtdZkM4ZA/lqbf20XRt3tR3vQic1RG+gSiipHa082lrFeJntOO3nL6y
        th0tSkAnySXos78OuuOupQOTbIqiHOC5RM5RDCtt86BUATvPwCygEQGPiY1c2rMXDglxq26ZxUHjd
        msVefU68/GFcLY3Vs1Mt7LyDHUYqx6nUIuYz/IWEJAxO+kEDCvTyVrRF9ed8BsbP8AEHXp6NHAjQ4
        s9lEnYkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o27ag-006QLd-PI; Fri, 17 Jun 2022 08:44:30 +0000
Date:   Fri, 17 Jun 2022 01:44:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kwankhede@nvidia.com, corbet@lwn.net, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com,
        akrowiak@linux.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, cohuck@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, jchrist@linux.ibm.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFT][PATCH v1 5/6] vfio/ccw: Add kmap_local_page() for memcpy
Message-ID: <Yqw+7gM3Lz96UFdz@infradead.org>
References: <20220616235212.15185-1-nicolinc@nvidia.com>
 <20220616235212.15185-6-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616235212.15185-6-nicolinc@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 16, 2022 at 04:52:11PM -0700, Nicolin Chen wrote:
> The pinned PFN list returned from vfio_pin_pages() is simply converted
> using page_to_pfn() without protection, so direct access via memcpy()
> will crash on S390 if the PFN is an IO PFN. Instead, the pages should
> be touched using kmap_local_page().

I don't see how this helps.  kmap_local_page only works for either
pages in the kernel direct map or highmem, but not for memory that needs
to be ioremapped.  And there is no highmem on s390.
