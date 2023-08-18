Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7087807D4
	for <lists+linux-s390@lfdr.de>; Fri, 18 Aug 2023 11:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbjHRJCy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 18 Aug 2023 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359013AbjHRJCU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Aug 2023 05:02:20 -0400
X-Greylist: delayed 1490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:01:58 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BEE3C26
        for <linux-s390@vger.kernel.org>; Fri, 18 Aug 2023 02:01:58 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id 1BE8584819; Fri, 18 Aug 2023 09:16:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346627; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=MyIpcAhqPAGkE7u+owDeDz68IJdbeyfTXOJi63jcUxpreiOgqYQXvWsUyGeUeu316
         BGdJ4CNZIOxkeRwESsyslgLhJEhLzoqyT7FtXwWaBgst2DRtrAdiw/RE3PxvoSrISj
         vNFZQosN9O87QtCtlemobUZEgMuvmg0Kox/DKyN9PfOVTo6vJnW/H+xXdy5tecTH+R
         7Cy+5xqXAmmXa85liwa+l9/oCqAg0v/9mTs4HxQJt4lCjaBWnHmTswQZHPHKs/aduv
         AX34j4NYJbyjFNATyqNAbb3hKQUinCR/ehMzF+dL2uSd6FJxBU0PdxvqZVm6bIlE4K
         0Fyn3Ng8W/lSg==
Received: by mail.leachkin.pl for <linux-s390@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.cumu.0.g4n1r0ui5g@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-s390@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
